import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
from io import BytesIO
import altair as alt

# Set page config
st.set_page_config(page_title="NYISO VLR Tool", layout="wide")

# Custom CSS for better UI and button sizing
st.markdown("""
    <style>
        .title-container { text-align: center; }
        .title-container h1 { color: #2E86C1; }
        .stButton button { width: 100%; height: 40px; font-size: 14px; }
        .stSelectbox div[data-baseweb="select"] { height: 35px !important; }
        .stNumberInput input { height: 35px !important; font-size: 14px; }
        .stDataFrame { border: 1px solid #ddd; border-radius: 5px; }
    </style>
""", unsafe_allow_html=True)

#############################################
# SECTION 1: FETCH LATEST DATA FROM DATABASE
#############################################

st.markdown("<div class='title-container'><h1>NYISO VLR Data Processing Tool</h1></div>", unsafe_allow_html=True)
st.markdown("---")
#st.header("Fetch Latest Data from Database")
# Establish connection

# Database connection parameters
db_params = {
    'dbname': 'trueprice',
    'user': 'postgres',
    'password': 'postgres',
    'host': 'localhost',
    'port': '5432'
}

# Establish connection
# engine = create_engine(f"postgresql+psycopg2://{db_params['user']}:{db_params['password']}@{db_params['host']}:{db_params['port']}/{db_params['dbname']}")
engine = create_engine("postgresql://postgres:191978@localhost:5432/vlr_nyiso")
start_date = st.date_input("Start Date", value=pd.to_datetime("2024-01-01"))
end_date = st.date_input("End Date", value=pd.to_datetime("today"))
def fetch_data(start_date='2020-01-01', end_date='2024-06-30'):
    query_data = """
        SELECT hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data as hourly_vlr_cost
        FROM nyiso_vlr_hourly_cost
        WHERE date BETWEEN %(start)s AND %(end)s
    """
    query_hierarchy = "SELECT * FROM nyiso_vlr_hierarchy"
    
    # Load data into DataFrames
    # data_df = pd.read_sql(query_data, engine)
    df = pd.read_sql(query_data, engine, params={"start": start_date, "end": end_date})
    df["date"] = pd.to_datetime(df["date"])
    df["year"] = df["date"].dt.year
    df["month"] = df["date"].dt.month
    df["day"] = pd.to_datetime(df["date"]).apply(lambda x: x.isoweekday() % 7 + 1)
    df["day_type"] = df["date"].dt.dayofweek.apply(lambda x: "WeekEnd" if x in [5, 6] else "WeekDay")
    df["hour_type"] = df["he"].apply(lambda x: "OnPeak" if 7 <= x <= 22 else "OffPeak")

    # Step 3: Calculate block type
    def calculate_block_type(row):
        if row["day_type"] == "WeekDay" and row["hour_type"] == "OnPeak":
            return "5x16"
        elif row["day_type"] == "WeekEnd" and row["hour_type"] == "OnPeak":
            return "2x16"
        else:
            return "7x8"

    df["block_type"] = df.apply(calculate_block_type, axis=1)

    # Step 4: Create grouping string
    df["concat_string"] = df["month"].astype(str) + "_" + df["he"].astype(str) + "_" + df["block_type"]

    # Step 5: Mode function
    def mode_function(x):
        return x.mode()[0] if not x.mode().empty else None

    # Step 6: Group and aggregate
    agg_df = df.groupby(["hierarchy_id", "concat_string"]).agg({
        "date": "first",
        "year": "first",
        "month": "first",
        "day": "first",
        "day_type": mode_function,
        "hourly_vlr_cost": "mean",
        "he": "mean",
        "hour_type": mode_function,
        "block_type": mode_function
    }).reset_index()

    # Final formatting
    agg_df = agg_df.sort_values(by=['hierarchy_id', 'month', 'he'])
    agg_df.rename(columns={"hourly_vlr_cost": "data"}, inplace=True)
    agg_df["data"] = agg_df["data"].round(6)

    agg_df = agg_df[["hierarchy_id", "date", "year", "month", "day", "day_type", "he", "hour_type", "block_type", "data"]]

    hierarchy_df = pd.read_sql(query_hierarchy, engine)
    
    if 'id' not in hierarchy_df.columns:
        st.error("ERROR: 'id' column is missing in vlr_hierarchy. Check database schema.")
        return None
    
    # Merge VLR data with hierarchy table
    merged_df = agg_df.merge(hierarchy_df, left_on='hierarchy_id', right_on='id', how='left')
    
    if 'block_type_x' in merged_df.columns:
        merged_df.rename(columns={'block_type_x': 'block_type'}, inplace=True)
    
    # Pivot table excluding `date`, `year`, and `day`
    pivot_df = pd.pivot_table(
        merged_df,
        values='data',
        index=['month', 'he', 'day_type', 'hour_type', 'block_type'], 
        columns=['control_area', 'state', 'load_zone', 'capacity_zone', 'utility', 'block_type_y', 'cost_group', 'cost_component', 'uom'],
        aggfunc='first' 
    )
    
    pivot_df.reset_index(inplace=True)
    
    return pivot_df
st.title("Fetch Latest VLR Cost % Data")

if st.button("Download"):
    pivot_df = fetch_data(start_date=start_date,end_date=end_date)
    if pivot_df is not None:
        st.success("Data fetched successfully! Download the file below.")
        
        # CSV Download
        csv_buffer = BytesIO()
        pivot_df.to_csv(csv_buffer)
        csv_buffer.seek(0)
        st.download_button("Download CSV", csv_buffer, "shaping_cost.csv", "text/csv")
        
        # XLSX Download
        xlsx_buffer = BytesIO()
        with pd.ExcelWriter(xlsx_buffer, engine='xlsxwriter') as writer:
            pivot_df.to_excel(writer, sheet_name="Shaping Cost")
        xlsx_buffer.seek(0)
        st.download_button("Download XLSX", xlsx_buffer, "shaping_cost.xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
####################################################
# Section 2: Upload File for Further Processing
####################################################

st.header("Upload File for Scaling and ABS Processing")

uploaded_file = st.file_uploader("Upload a file", type=["xlsx", "csv"], key="abs_upload")

if uploaded_file is None:
    st.info("Please upload a file to display and update the data.")
else:
    if uploaded_file.name.endswith('.xlsx'):
        original_df = pd.read_excel(uploaded_file)
        start = 9
    else:
        original_df = pd.read_csv(uploaded_file)
        start = 8

    # Process the DataFrame
    df = original_df.copy()
    df.columns = (
        ["control_area", "month", "he", "day_type", "hour_type", "block_type"] +
        list(df.iloc[1, 6:])
    )
    df = df.iloc[start:, 1:].reset_index(drop=True)

    st.markdown("""
        <div class='title-container'>
            <h1>NYISO VLR Data ABS and Scalar Converter</h1>
        </div>
    """, unsafe_allow_html=True)

    # Detect zone columns
    zone_columns = [col for col in df.columns if "Z" in col.upper()]

    if zone_columns:
        st.markdown("### Configure Settings for Each Zone")
        zone_settings = {}

        for zone in zone_columns:
            col1, col2 = st.columns(2)
            with col1:
                scaler = st.number_input(
                    f"{zone} Scaler (%)",
                    min_value=100, max_value=500, value=100, step=10,
                    key=f"{zone}_scaler"
                ) / 100.0
            with col2:
                abs_option = st.selectbox(
                    f"{zone} Absolute",
                    ["No", "Yes"],
                    index=0,
                    key=f"{zone}_abs"
                )
            zone_settings[zone] = {"scaler": scaler, "abs": abs_option}

        for zone, settings in zone_settings.items():
            df[zone] = df[zone].astype(float) * settings["scaler"]
            if settings["abs"] == "Yes":
                df[zone] = df[zone].abs()

        # ✅ Save to session state for use in plotting section
        st.session_state["nyiso_processed_df"] = df.copy()

    else:
        st.warning("No zone columns detected in the file.")

    st.dataframe(df, use_container_width=True)
    st.write("Successfully updated the File!")

    original_df.iloc[start:, 1:] = df.values

    buffer = BytesIO()
    with pd.ExcelWriter(buffer, engine='xlsxwriter') as writer:
        original_df.to_excel(writer, index=False, sheet_name='Updated Data')
    buffer.seek(0)
    st.download_button("Download Processed Data as Excel", buffer, "processed_ercot_vlr.xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")

    csv_buffer = BytesIO()
    original_df.to_csv(csv_buffer, index=False)
    csv_buffer.seek(0)
    st.download_button("Download Processed Data as CSV", csv_buffer, "processed_ercot_vlr.csv", "text/csv")
st.header("📊 Multi-Zone Monthly Average Plot")


if "nyiso_processed_df" not in st.session_state:
    st.info("Please upload and process a file above first.")
else:
    df = st.session_state["nyiso_processed_df"].copy()

    # Ensure numeric month and hour
    df["month"] = pd.to_numeric(df["month"], errors="coerce")
    df["he"] = pd.to_numeric(df["he"], errors="coerce")
    df.dropna(subset=["month", "he"], inplace=True)
    df["month"] = df["month"].astype(int)
    df["he"] = df["he"].astype(int)

    # Detect all ZONE columns
    zone_columns = [col for col in df.columns if "Z" in col.upper()]

    if not zone_columns:
        st.warning("No zone columns found.")
    else:
        # 🔽 Select grouping option
        view_option = st.radio("Choose Grouping Type:", ["Monthly", "Hourly"], horizontal=True)

        # 🔽 Multi-select for user zone input
        selected_zones = st.multiselect(
            "Select Zone(s) to Plot",
            options=zone_columns,
            default=zone_columns
        )

        if not selected_zones:
            st.info("Select at least one zone to see the plot.")
        else:
            # Melt only selected zones
            group_col = "month" if view_option == "Monthly" else "he"
            melted_df = df[[group_col] + selected_zones].melt(
                id_vars=[group_col],
                var_name="zone",
                value_name="value"
            )

            # Clean numeric values
            melted_df["value"] = pd.to_numeric(melted_df["value"], errors="coerce")
            melted_df.dropna(inplace=True)

            # Group and average
            avg_df = (
                melted_df.groupby([group_col, "zone"], as_index=False)
                .agg({"value": "mean"})
            )

            # Dynamic x-axis title
            x_axis_title = "Month" if view_option == "Monthly" else "Hour Ending"

            # Altair multi-line chart
            chart = alt.Chart(avg_df).mark_line(point=True).encode(
                x=alt.X(f"{group_col}:O", title=x_axis_title),
                y=alt.Y("value:Q", title="Average VLR"),
                color="zone:N",
                tooltip=[group_col, "zone", "value"]
            ).properties(
                title=f"📊 {view_option} Average VLR by Zone",
                width=800,
                height=400
            )

            st.altair_chart(chart, use_container_width=True)
