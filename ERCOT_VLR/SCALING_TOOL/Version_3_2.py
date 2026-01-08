import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
from io import BytesIO
import altair as alt

# Set page config
st.set_page_config(page_title="NYISO VLR Tool", layout="wide")

# Custom CSS
st.markdown("""
    <style>
        .title-container { text-align: center; }
        .title-container h1 { color: #2E86C1; }
        .stButton button { width: 100%; height: 40px; font-size: 14px; }
        .stSelectbox div[data-baseweb="select"] { height: 35px !important; }
        .stNumberInput input { height: 35px !important; font-size: 14px; }
        .stDataFrame { border: 1px solid #ddd; border-radius: 5px; padding: 5px; }
        .compact-number { width: 90px !important; }
        .zone-card {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #e9ecef;
        }
        .zone-settings-container {
            max-height: 500px;
            overflow-y: auto;
            padding-right: 10px;
            border-right: 1px solid #ddd;
        }
        /* Hide Streamlit branding */
        #MainMenu {visibility: hidden;}
        footer {visibility: hidden;}
        /* Make widgets more compact */
        div.row-widget.stRadio > div {
            flex-direction: row;
            align-items: center;
        }
        div.row-widget.stRadio > div > label {
            margin: 0px 10px;
            padding: 5px 10px;
        }

        .zone-settings-container {
            max-height: 600px;
            overflow-y: auto;
            padding-right: 10px;
            border-right: 1px solid #ddd;
            scrollbar-width: thin;
        }
        
        /* Additional styles for the table view */
        .settings-table {
            width: 100%;
            border-collapse: collapse;
        }
        .settings-table th, .settings-table td {
            padding: 5px;
            text-align: left;
        }
        .settings-table th {
            background-color: #f0f2f6;
            font-weight: bold;
        }
</style>

""", unsafe_allow_html=True)

# Database engine
engine = create_engine("postgresql://postgres:191978@localhost:5432/vlr_nyiso")

# Main navigation - keep this for the main sections
tab1, tab2, tab3 = st.tabs(["📥 Fetch Data", "📤 Upload & Process / Analytics", "💡 Advanced Tools"])

###############################
# Utility: Fetch Data Function
###############################
def fetch_data(start_date='2020-01-01', end_date='2024-06-30'):
    query_data = """
        SELECT hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data as hourly_vlr_cost
        FROM nyiso_vlr_hourly_cost
        WHERE date BETWEEN %(start)s AND %(end)s
    """
    query_hierarchy = "SELECT * FROM nyiso_vlr_hierarchy"

    df = pd.read_sql(query_data, engine, params={"start": start_date, "end": end_date})
    df["date"] = pd.to_datetime(df["date"])
    df["year"] = df["date"].dt.year
    df["month"] = df["date"].dt.month
    df["day"] = df["date"].dt.day
    df["day_type"] = df["date"].dt.dayofweek.apply(lambda x: "WeekEnd" if x in [5, 6] else "WeekDay")
    df["hour_type"] = df["he"].apply(lambda x: "OnPeak" if 7 <= x <= 22 else "OffPeak")

    def calculate_block_type(row):
        if row["day_type"] == "WeekDay" and row["hour_type"] == "OnPeak":
            return "5x16"
        elif row["day_type"] == "WeekEnd" and row["hour_type"] == "OnPeak":
            return "2x16"
        else:
            return "7x8"

    df["block_type"] = df.apply(calculate_block_type, axis=1)
    df["concat_string"] = df["month"].astype(str) + "_" + df["he"].astype(str) + "_" + df["block_type"]

    def mode_function(x):
        return x.mode()[0] if not x.mode().empty else None

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

    agg_df = agg_df.sort_values(by=['hierarchy_id', 'month', 'he'])
    agg_df.rename(columns={"hourly_vlr_cost": "data"}, inplace=True)
    agg_df["data"] = agg_df["data"].round(6)

    hierarchy_df = pd.read_sql(query_hierarchy, engine)
    if 'id' not in hierarchy_df.columns:
        st.error("ERROR: 'id' column is missing in hierarchy table.")
        return None

    merged_df = agg_df.merge(hierarchy_df, left_on='hierarchy_id', right_on='id', how='left')
    if 'block_type_x' in merged_df.columns:
        merged_df.rename(columns={'block_type_x': 'block_type'}, inplace=True)

    pivot_df = pd.pivot_table(
        merged_df,
        values='data',
        index=['month', 'he', 'day_type', 'hour_type', 'block_type'],
        columns=['control_area', 'state', 'load_zone', 'capacity_zone', 'utility', 'block_type_y', 'cost_group', 'cost_component', 'uom'],
        aggfunc='first'
    )
    pivot_df.reset_index(inplace=True)
    return pivot_df

#########################
# TAB 1: Fetch from DB
#########################
with tab1:
    st.markdown("<div class='title-container'><h1>NYISO VLR Data Processing Tool</h1></div>", unsafe_allow_html=True)
    st.markdown("---")
    st.title("Fetch Latest VLR Cost % Data")

    start_date = st.date_input("Start Date", value=pd.to_datetime("2024-01-01"))
    end_date = st.date_input("End Date", value=pd.to_datetime("today"))

    if st.button("Download"):
        pivot_df = fetch_data(start_date, end_date)
        if pivot_df is not None:
            st.success("Data fetched successfully! Download the file below.")

            csv_buf = BytesIO()
            pivot_df.to_csv(csv_buf)
            csv_buf.seek(0)
            st.download_button("Download CSV", csv_buf, "shaping_cost.csv", "text/csv")

            xlsx_buf = BytesIO()
            with pd.ExcelWriter(xlsx_buf, engine='xlsxwriter') as writer:
                pivot_df.to_excel(writer, sheet_name="Shaping Cost")
            xlsx_buf.seek(0)
            st.download_button("Download XLSX", xlsx_buf, "shaping_cost.xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")

#########################
# TAB 2: Split-Screen Upload & Process + Analytics
#########################
with tab2:
    st.markdown("<div class='title-container'><h1>NYISO VLR Data Processing & Analytics</h1></div>", unsafe_allow_html=True)
    
    # Upload file section (at top)
    uploaded_file = st.file_uploader("Upload a file", type=["xlsx", "csv"], key="abs_upload")
    
    if uploaded_file is not None:
        original_df = pd.read_excel(uploaded_file) if uploaded_file.name.endswith(".xlsx") else pd.read_csv(uploaded_file)
        start = 9 if uploaded_file.name.endswith(".xlsx") else 8

        df = original_df.copy()
        df.columns = (
            ["control_area", "month", "he", "day_type", "hour_type", "block_type"] +
            list(df.iloc[1, 6:])
        )
        df = df.iloc[start:, 1:].reset_index(drop=True)
        
        # Convert month and he to numeric for proper processing
        df["month"] = pd.to_numeric(df["month"], errors="coerce")
        df["he"] = pd.to_numeric(df["he"], errors="coerce")
        df.dropna(subset=["month", "he"], inplace=True)
        df["month"] = df["month"].astype(int)
        df["he"] = df["he"].astype(int)
        
        # Identify zone columns
        zone_columns = [col for col in df.columns if "Z" in col.upper()]
        
        if zone_columns:
            # Create split screen layout
            left_col, right_col = st.columns([1, 2])
            
            # Left column: Controls panel in a more compact and tabular form
            with left_col:
                st.subheader("Zone Settings")

                zone_settings = {}

                # Group Controls (not scrollable)
                with st.expander("⚙️ Group Controls", expanded=True):
                    group_scaler = st.number_input("All Zones Scaler (%)", 100, 500, 100, 10, key="group_scaler")
                    group_abs = st.selectbox("All Zones Absolute", ["No", "Yes"], index=0, key="group_abs")

                    if st.button("Apply to All Zones"):
                        for zone in zone_columns:
                            st.session_state[f"{zone}_scaler"] = group_scaler
                            st.session_state[f"{zone}_abs"] = group_abs

                # Create a table-like interface for zone settings
                st.markdown("#### Zone Settings Table")
                
                # Create columns for the table header
                cols = st.columns([3, 3, 2])
                cols[0].markdown("**Zone**")
                cols[1].markdown("**Scale (%)**")
                cols[2].markdown("**ABS**")
                
                # Create a container for the scrollable table
                with st.container():
                    st.markdown('<div class="zone-settings-container">', unsafe_allow_html=True)
                    
                    # Each zone gets a row in the table
                    for zone in zone_columns:
                        zone_cols = st.columns([3, 3, 2])
                        
                        # Column 1: Zone name
                        zone_cols[0].markdown(f"**{zone}**")
                        
                        # Column 2: Scaler input
                        scaler = zone_cols[1].number_input(
                            "Scale",
                            0, 10000,
                            key=f"{zone}_scaler",
                            value=st.session_state.get(f"{zone}_scaler", 100),
                            step=25,
                            label_visibility="collapsed"
                        )
                        
                        # Column 3: ABS dropdown
                        abs_option = zone_cols[2].selectbox(
                            "ABS",
                            options=["No", "Yes"],
                            key=f"{zone}_abs",
                            index=0 if st.session_state.get(f"{zone}_abs", "No") == "No" else 1,
                            label_visibility="collapsed"
                        )
                        
                        zone_settings[zone] = {"scaler": scaler / 100.0, "abs": abs_option}
                    
                    st.markdown('</div>', unsafe_allow_html=True)

                # Apply settings to dataframe
                df_processed = df.copy()
                for zone, settings in zone_settings.items():
                    df_processed[zone] = df_processed[zone].astype(float) * settings["scaler"]
                    if settings["abs"] == "Yes":
                        df_processed[zone] = df_processed[zone].abs()

                st.session_state["nyiso_processed_df"] = df_processed.copy()

                # Download buttons
                buffer = BytesIO()
                original_df.iloc[start:, 1:] = df_processed.values
                with pd.ExcelWriter(buffer, engine='xlsxwriter') as writer:
                    original_df.to_excel(writer, index=False, sheet_name='Updated Data')
                buffer.seek(0)

                st.download_button("📊 Download Excel", buffer, "processed_nyiso_vlr.xlsx")

                csv_buf = BytesIO()
                original_df.to_csv(csv_buf, index=False)
                csv_buf.seek(0)

                st.download_button("📝 Download CSV", csv_buf, "processed_nyiso_vlr.csv")

            
            # Right column: Analytics with bigger visuals
            with right_col:
                # Tabs for different visualizations
                viz_tab1, viz_tab2 = st.tabs(["📊 Plot View", "🔢 VLR Calculator"])
                
                with viz_tab1:
                    view_option = st.radio("View Type:", ["Monthly", "Hourly"], horizontal=True)
                    
                    # More compact zone selection - avoid nested columns
                    selected_zones = st.multiselect("Select Zone(s)", options=zone_columns, 
                                                   default=zone_columns[:min(3, len(zone_columns))])
                    
                    show_data_table = st.checkbox("Show Data Table", key="show_data_table", value=False)
                    
                    if selected_zones:
                        group_col = "month" if view_option == "Monthly" else "he"
                        df_for_plot = st.session_state["nyiso_processed_df"].copy()
                        
                        melted_df = df_for_plot[[group_col] + selected_zones].melt(
                            id_vars=[group_col], var_name="zone", value_name="value"
                        )
                        melted_df["value"] = pd.to_numeric(melted_df["value"], errors="coerce")
                        melted_df.dropna(inplace=True)
                        
                        avg_df = melted_df.groupby([group_col, "zone"], as_index=False).agg({"value": "mean"})
                        
                        x_axis_title = "Month" if view_option == "Monthly" else "Hour Ending"
                        
                        # More modern chart with smoother lines and better aesthetics
                        chart = alt.Chart(avg_df).mark_line(
                            point=True,
                            strokeWidth=3,
                            interpolate='monotone'
                        ).encode(
                            x=alt.X(f"{group_col}:O", title=x_axis_title),
                            y=alt.Y("value:Q", title="Average VLR"),
                            color=alt.Color("zone:N", legend=alt.Legend(
                                orient="top",
                                title=None,
                                labelFontSize=12
                            )),
                            tooltip=[group_col, "zone", alt.Tooltip("value:Q", format=".4f")]
                        ).properties(
                            title=f"{view_option} Average VLR by Zone",
                            width=600,
                            height=400
                        ).configure_axis(
                            labelFontSize=12,
                            titleFontSize=14
                        ).configure_title(
                            fontSize=16
                        )
                        
                        st.altair_chart(chart, use_container_width=True)
                        
                        # Show data table if requested
                        if show_data_table:
                            pivot_data = avg_df.pivot(index=group_col, columns="zone", values="value")
                            st.dataframe(pivot_data.style.format("{:.6f}"), use_container_width=True)
                    else:
                        st.info("Please select at least one zone to plot.")
                
                with viz_tab2:
                    st.subheader("VLR-Based Scenario Calculator")
                    
                    # Calculate zone VLR averages
                    df_calc = st.session_state["nyiso_processed_df"].copy()
                    avg_vlrs = df_calc[zone_columns].astype(float).mean().round(6)
                    
                    # Display settings and avg VLR% 
                    st.markdown("#### Zone Settings Summary")
                    
                    # Display zone settings in a simple list instead of a grid to avoid nesting issues
                    for zone in zone_columns:
                        st.markdown(f"""
                        <div style="background-color:#f0f2f6; padding:10px; border-radius:5px; margin-bottom:5px;">
                            <strong>{zone}</strong> - 
                            VLR: <code>{avg_vlrs[zone]*100:.4f}%</code> | 
                            ABS: <code>{zone_settings[zone]['abs']}</code> | 
                            Scaler: <code>{zone_settings[zone]['scaler']*100:.0f}%</code>
                        </div>
                        """, unsafe_allow_html=True)
                    
                    st.markdown("---")
                    
                    # LMP scenario calculator - avoid nested columns
                    lmp_values = st.text_input("Enter LMP values (comma separated)", 
                                             "50,100,200,500,1000")
                    
                    try:
                        lmp_list = [float(x.strip()) for x in lmp_values.split(",") if x.strip()]
                        
                        # Prepare table data
                        calc_data = {"LMPs ($)": [f"${val:,.2f}" for val in lmp_list]}
                        
                        for zone in zone_columns:
                            avg = avg_vlrs[zone]
                            result = [(avg * val) for val in lmp_list]
                            calc_data[zone] = [f"${r:.2f}" for r in result]
                        
                        # Display as dataframe with styling
                        result_df = pd.DataFrame(calc_data)
                        st.dataframe(result_df, use_container_width=True)
                        
                    except:
                        st.error("Invalid LMP values. Please enter comma-separated numbers.")
        else:
            st.warning("No zone columns detected in the file.")
    else:
        st.info("Please upload a file to begin processing.")

#########################
# TAB 3: Advanced Tools
#########################
with tab3:
    st.header("💡 Advanced Tools & Reports")
    st.info("Additional advanced features can be added here in the future.")
    
    # Placeholder for future advanced features
    st.markdown("""
    Some ideas for future features:
    - Long-term trend analysis
    - Seasonal pattern detection
    - Correlation with market indicators
    - Export to Power BI/Tableau
    """)