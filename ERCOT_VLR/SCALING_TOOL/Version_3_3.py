import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
from io import BytesIO
import altair as alt
import xlsxwriter
from io import TextIOWrapper
from sqlalchemy import create_engine
from streamlit_autorefresh import st_autorefresh
import os
from dotenv import load_dotenv
import streamlit as st

# 💡 Install this small library first (if not done)
# pip install streamlit-toggle-switch

from streamlit_toggle import st_toggle_switch

# Set page config
st.set_page_config(page_title="EPDC Automation", layout="wide")

# Load environment variables
load_dotenv()

# Database connection parameters from .env
db_params = {
    'dbname': os.getenv("DB_NAME", "epdauto"),
    'user': os.getenv("DB_USER", "postgres"),
    'password': os.getenv("DB_PASSWORD", "postgres"),
    'host': os.getenv("DB_HOST", "localhost"),
    'port': os.getenv("DB_PORT", "5432")
}

# Create database engine
engine = create_engine(f"postgresql+psycopg2://{db_params['user']}:{db_params['password']}@{db_params['host']}:{db_params['port']}/{db_params['dbname']}")

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
            background-color: #000000; /* bright white background */
            border: 1px solid #333333; /* subtle gray border */
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05); /* light shadow */
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 15px; /* bigger text */
            font-weight: 500;
        }
        .zone-card strong {
            font-size: 15px; /* even bigger zone name */
            color: white; /* same blue as your title */
        }
        .zone-card code {
            background-color: #1c1c1c;
            color: #00FF00
            padding: 4px 8px;
            border-radius: 5px;
            font-size: 14px;
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



# Global heading BEFORE tabs
st.markdown("<div class='title-container'><h1>EnerPrice Data Automation Tool</h1></div>", unsafe_allow_html=True)
st.markdown("---")

# # Database engine
# engine = create_engine("postgresql://postgres:postgres@localhost:5432/trueprice")

colA, colB = st.columns(2)

with colA:
    iso_option = st.selectbox("Select ISO", ["ERCOT", "NYISO","ISONE","MISO","PJM"], index=0)

with colB:
    curve_option = st.selectbox("Select Curve Type", ["VLR", "Shaping"], index=0)

# --- Mapping Tables ---
TABLE_MAPPING = {
    ("ERCOT", "VLR"): ("ercot_vlr_hourly_cost", "ercot_vlr_hierarchy"),
    ("ISONE", "VLR"): ("isone_vlr_hourly_cost", "isone_vlr_hierarchy"),
    ("NYISO", "VLR"): ("nyiso_vlr_hourly_cost", "nyiso_vlr_hierarchy"),
    ("PJM", "VLR"): ("pjm_vlr_hourly_cost", "pjm_vlr_hierarchy"),# added new 
    ("MISO", "VLR"): ("miso_vlr_hourly_cost", "miso_vlr_hierarchy"),# added new 
    ("ERCOT", "Shaping"): ("ercot_shaping_da_lmps_avg", "ercot_hierarchy"),
    ("ISONE", "Shaping"): ("da_lmps_avg_isone", "isone_hierarchy"),
    # ("NYISO", "Shaping"): ("da_lmps_avg_nyiso", "nyiso_shaping"),
    # ("MISO", "Shaping"): ("da_lmps_avg_miso", "miso_shaping"),
    # ("PJM", "Shaping"): ("da_lmps_avg_pjm", "pjm_shaping"),
    ("NYISO", "Shaping"): ("da_lmps_avg_nyiso", "nyiso_hierarchy"),
    ("MISO", "Shaping"): ("da_lmps_avg_miso", "miso_hierarchy"),
    ("PJM", "Shaping"): ("da_lmps_avg_pjm", "pjm_hierarchy"),
}

# Dynamic Title based on selection
st.markdown(f"<div class='title-container'><h1>{iso_option} {curve_option} Data Processing Tool</h1></div>", unsafe_allow_html=True)
st.markdown("---")


def get_date_range(selected_iso, selected_curve):
    data_table, _ = TABLE_MAPPING.get((selected_iso, selected_curve), (None, None))
    if data_table:
        query = f"SELECT MIN(date) AS min_date, MAX(date) AS max_date FROM {data_table}"
        try:
            df_dates = pd.read_sql(query, engine)
            min_date, max_date = pd.to_datetime(df_dates.loc[0, 'min_date']), pd.to_datetime(df_dates.loc[0, 'max_date'])
            return min_date, max_date
        except Exception as e:
            st.error(f"Error fetching date range: {e}")
            return pd.to_datetime("2020-01-01"), pd.to_datetime("today")
    else:
        st.error("Invalid ISO/Curve Combination")
        return pd.to_datetime("2020-01-01"), pd.to_datetime("today")




# Fetch default dates based on table
#default_start_date, default_end_date = get_date_range(iso_option, curve_option)
# Dynamic Dates Handling with Session State
# Session State for Dates
if "last_iso" not in st.session_state: st.session_state.last_iso = None
if "last_curve" not in st.session_state: st.session_state.last_curve = None
if "start_date" not in st.session_state or "end_date" not in st.session_state:
    st.session_state.start_date, st.session_state.end_date = get_date_range(iso_option, curve_option)

if st.session_state.last_iso != iso_option or st.session_state.last_curve != curve_option:
    st.session_state.start_date, st.session_state.end_date = get_date_range(iso_option, curve_option)
    st.session_state.last_iso, st.session_state.last_curve = iso_option, curve_option


# Main navigation - keep this for the main sections
tab1, tab2, tab3 = st.tabs(["📥 Fetch Data", "📤 Upload & Process / Analytics", "💡 Advanced Tools"])

###############################
# Utility: Fetch Data Function
###############################
def fetch_data(start_date='2020-01-01', end_date='2024-06-30', iso_option="ISONE", curve_option="VLR"):
    data_table, hierarchy_table = TABLE_MAPPING.get((iso_option, curve_option), (None, None))
    if not data_table or not hierarchy_table:
        st.error("Invalid ISO/Curve Selection")
        return None

    df_data = pd.read_sql(f"SELECT * FROM {data_table}", engine)
    df_hierarchy = pd.read_sql(f"SELECT * FROM {hierarchy_table}", engine)

    if df_data.empty or df_hierarchy.empty:
        st.error("No data found in table")
        return None
    
    if curve_option == "VLR":
        query_data = f"""
            SELECT hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data as hourly_vlr_cost
            FROM {data_table}
            WHERE date BETWEEN %(start)s AND %(end)s
        """
        query_hierarchy = f"SELECT * FROM {hierarchy_table}"
        
        df = pd.read_sql(query_data, engine, params={"start": start_date, "end": end_date})

        if df.empty:
            st.warning(f"No data found for selected range in {data_table}")
            return None
    # query_data = """
    #     SELECT hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data as hourly_vlr_cost
    #     FROM isone_vlr_hourly_cost
    #     WHERE date BETWEEN %(start)s AND %(end)s
    # """
    # query_hierarchy = "SELECT * FROM isone_vlr_hierarchy"
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
            # "day_type": mode_function,
            "hourly_vlr_cost": "mean",
            "he": "mean",
            # "hour_type": mode_function,
            "block_type": mode_function
        }).reset_index()

    # Final formatting
    # agg_df = agg_df.sort_values(by=['hierarchy_id', 'month', 'he'])
        agg_df.rename(columns={"hourly_vlr_cost": "data"}, inplace=True)
        agg_df["data"] = agg_df["data"].round(6)
    
        agg_df = agg_df[["hierarchy_id", "date", "year", "month", "day", "he", "block_type", "data"]]
    
        hierarchy_df = pd.read_sql(query_hierarchy, engine)
        
        if 'id' not in hierarchy_df.columns:
            return None
        
        # Merge VLR data with hierarchy table
        merged_df = agg_df.merge(hierarchy_df, left_on='hierarchy_id', right_on='id', how='left')
        # merged_df.columns = [i[0].upper() for i in merged_df.columns]
        merged_df.columns = [i[0].capitalize() if isinstance(i, tuple) else i.capitalize() for i in merged_df.columns]
    
        if 'Block_type_x' in merged_df.columns:
            merged_df.rename(columns={'Block_type_x': 'Block Type'}, inplace=True)
        # print(merged_df)
        pivoted_df = pd.pivot_table(merged_df, values='Data', index=[ "Month", "He", "Block Type"], columns=["Control_area", "State", "Load_zone", "Capacity_zone", "Utility", "Block_type_y", "Cost_group", "Cost_component"], aggfunc='first')
    
          
        return pivoted_df

    else: #Shaping Logic              
        query = f"""
            SELECT hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data
            FROM {data_table}
            WHERE date BETWEEN %(start)s AND %(end)s
        """
        
        df = pd.read_sql(query, engine, params={"start": start_date, "end": end_date})

        df_hierarchy = pd.read_sql(f"SELECT * FROM {hierarchy_table}", engine)
        
        if df_hierarchy.empty:
            st.warning(f"No hierarchy data found for {hierarchy_table}")
            return None
        
        if df.empty:
            st.warning(f"No data found for {shaping_table}")
            return None

        df = df.drop_duplicates(subset=["hierarchy_id", "date", "month", "he", "block_type"])

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

        df_numerator = df.groupby(["hierarchy_id", "month", "he", "block_type"], as_index=False)["data"].mean().round(6)
        df_denominator = df.groupby(["hierarchy_id", "month", "block_type"], as_index=False)["data"].mean().round(6)

        df_final = pd.merge(df_numerator, df_denominator, on=["hierarchy_id", "month", "block_type"], how="left")
        df_final["data"] = df_final["data_x"] / df_final["data_y"]
        df_final = df_final.drop(columns=["data_x", "data_y"])
        df_final["data"] = df_final["data"].round(6)
        
        df_dates = df.groupby(["hierarchy_id", "month", "he", "block_type"], as_index=False).first()
        df_final = pd.merge(
            df_final,
            df_dates[["hierarchy_id", "month", "he", "block_type", "date", "year", "day", "day_type", "hour_type"]],
            on=["hierarchy_id", "month", "he", "block_type"],
            how="left"
        )
    
        merged_df = df_final.merge(df_hierarchy, left_on='hierarchy_id', right_on='id', how='left')
        
        # Capitalize merged columns
        # merged_df.columns = [i[0].capitalize() if isinstance(i, tuple) else i.capitalize() for i in merged_df.columns]
        merged_df.columns = [col if col == "data" else col.capitalize() for col in merged_df.columns]

        # ✅ FINAL SAFETY STEP – if it somehow capitalized, rename back
        if "Data" in merged_df.columns:
            merged_df.rename(columns={"Data": "data"}, inplace=True)
    
        if 'Block_type_x' in merged_df.columns:
            merged_df.rename(columns={'Block_type_x': 'Block Type'}, inplace=True)

        pivoted_df = pd.pivot_table(
            merged_df,
            values='data',
            index=["Month", "He", "Block Type"],
            columns=["Control_area", "State", "Load_zone", "Capacity_zone", "Utility", "Block_type_y", "Cost_group", "Cost_component"],
            aggfunc='first'
        )
    
        return pivoted_df

        
#########################
# TAB 1: Fetch from DB
#########################
with tab1:
    st.title("Fetch Latest Data")

    col1, col2, col3 = st.columns([2, 2, 1])

    with col1:
        start_date = st.date_input("Start Date", value=st.session_state.start_date, key="tab1_start_date")

    with col2:
        end_date = st.date_input("End Date", value=st.session_state.end_date, key="tab1_end_date")

    with col3:
        st.markdown("<br>", unsafe_allow_html=True)
        download_clicked = st.button("Download", use_container_width=True)

    if download_clicked:
        pivot_df = fetch_data(start_date, end_date, iso_option, curve_option)

        if pivot_df is not None:
            st.success("Data fetched successfully! Download the file below.")

            # ---------------------------
            # STEP 1: Prepare Metadata Rows
            # ---------------------------
            n_index_cols = len(pivot_df.index.names)
            metadata_labels = pivot_df.columns.names
            metadata_rows = []

            for level in range(pivot_df.columns.nlevels):
                row = []
                row.append(metadata_labels[level] if metadata_labels[level] else "")  # Column A: Label
                row += [""] * (n_index_cols - 1)  # B & C: Empty for index columns
                row += [col[level] for col in pivot_df.columns]  # D+: metadata values
                metadata_rows.append(row)

            # ---------------------------
            # STEP 2: Flatten Column Names + Reset Index
            # ---------------------------
            data_df = pivot_df.copy()
            data_df.columns = ['VLR COST' if isinstance(col, tuple) else str(col) for col in data_df.columns]
            data_df.reset_index(inplace=True)

            # ---------------------------
            # STEP 3: CSV Export (Formatted)
            # ---------------------------
            csv_lines = []

            # 1. Metadata rows
            for row in metadata_rows:
                csv_lines.append(",".join(str(val) for val in row))

            # 2. Blank row
            csv_lines.append("")

            # 3. Header row
            csv_lines.append(",".join(data_df.columns))

            # 4. Data rows
            for row in data_df.itertuples(index=False):
                csv_lines.append(",".join(str(val) for val in row))

            # Write to buffer
            csv_buf = BytesIO()
            csv_buf.write("\n".join(csv_lines).encode('utf-8'))
            csv_buf.seek(0)

            # CSV Download Button
            st.download_button("Download CSV", csv_buf, f"{iso_option}_{curve_option}_data.csv", "text/csv")

            # ---------------------------
            # STEP 4: Excel Export
            # ---------------------------
            xlsx_buf = BytesIO()
            with pd.ExcelWriter(xlsx_buf, engine='xlsxwriter') as writer:
                worksheet = writer.book.add_worksheet(f"{iso_option}_{curve_option}_data.xlsx")
                writer.sheets["Shaping Cost"] = worksheet

                # Write metadata block
                for row_idx, row_data in enumerate(metadata_rows):
                    worksheet.write_row(row_idx, 0, row_data)

                # Leave blank row
                data_start_row = len(metadata_rows) + 1

                # Write data frame
                data_df.to_excel(
                    writer,
                    sheet_name="Shaping Cost",
                    startrow=data_start_row,
                    index=False,
                    header=True
                )

                # Optional: freeze header row + BlockType column
                worksheet.freeze_panes(data_start_row, 3)  # Row after header, col after "BlockType"

            xlsx_buf.seek(0)
            st.download_button(
                "Download XLSX",
                xlsx_buf,
                f"{iso_option}_{curve_option}_data.xlsx",
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            )




#########################
# TAB 2: Split-Screen Upload & Process + Analytics
#########################
with tab2:
    st.markdown(
    f"<div class='title-container'><h1>{iso_option} {curve_option} Data Processing & Analytics</h1></div>", 
    unsafe_allow_html=True
    )

    # Upload file section (at top)
    uploaded_file = st.file_uploader("Upload a file", type=["xlsx", "csv"], key="abs_upload")
    
    if uploaded_file is not None:
        if uploaded_file.name.endswith(".csv"):
            start = 9
            original_df = pd.read_csv(uploaded_file, header=None)

            metadata_part = original_df.iloc[:start - 1].copy()
            metadata_part.loc[len(metadata_part)] = [None] * metadata_part.shape[1]
            zone_columns = list(metadata_part.iloc[2, 3:])

            df = original_df.iloc[start:].copy().reset_index(drop=True)
            df.columns = ["Month", "He", "Block Type"] + zone_columns
            # metadata_part = metadata_part.iloc[:-1]

        else:  # Excel
            start = 10
            original_df = pd.read_excel(uploaded_file, header=None)

            metadata_part = original_df.iloc[:start - 1].copy()
            zone_columns = list(metadata_part.iloc[2, 3:])

            df = original_df.iloc[start:].copy().reset_index(drop=True)
            df.columns = ["Month", "He", "Block Type"] + zone_columns

        # Convert month and he to numeric for proper processing
        df["Month"] = pd.to_numeric(df["Month"], errors="coerce")
        df["He"] = pd.to_numeric(df["He"], errors="coerce")
        df.dropna(subset=["Month", "He"], inplace=True)
        df["Month"] = df["Month"].astype(int)
        df["He"] = df["He"].astype(int)
        
        # Identify zone columns
        # zone_columns = [col for col in df.columns if "Z" in col.upper()]
        # zone_columns = df.columns[3:]
        if len(zone_columns) != 0:
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

# Combine metadata + latest processed data for download
                if "nyiso_processed_df" in st.session_state and "metadata_part" in locals():
                    processed_df = st.session_state["nyiso_processed_df"]

                    # Step 1: Convert metadata to list of rows
                    metadata_rows = metadata_part.reset_index(drop=True).values.tolist()
                    # blank_row = [""] * len(processed_df.columns)

                    # Step 2: Prepare processed data rows (with header!)
                    data_header = list(processed_df.columns)
                    data_values = processed_df.reset_index(drop=True).values.tolist()
                    full_data = metadata_rows + [data_header] + data_values

                    # --- Excel Download ---
                    excel_buf = BytesIO()
                    # import xlsxwriter
                    workbook = xlsxwriter.Workbook(excel_buf, {'in_memory': True})
                    worksheet = workbook.add_worksheet("Updated Data")

                    for row_idx, row_data in enumerate(full_data):
                        clean_row = ["" if pd.isna(val) else val for val in row_data]
                        worksheet.write_row(row_idx, 0, clean_row)

                    workbook.close()
                    excel_buf.seek(0)
                    st.download_button("📥 Download Excel",excel_buf,f"processed_{iso_option.lower()}_{curve_option.lower()}.xlsx")

                    # --- CSV Download ---
                    
                    csv_buf = BytesIO()
                    wrapper = TextIOWrapper(csv_buf, encoding="utf-8", newline="")
                    import csv
                    writer = csv.writer(wrapper)

                    for row_idx, row_data in enumerate(full_data):
                        clean_row = ["" if pd.isna(val) else val for val in row_data]
                        writer.writerow(clean_row)  # ✅ correct CSV writing


                    wrapper.flush()
                    csv_buf.seek(0)
                    st.download_button("📝 Download CSV",csv_buf,f"processed_{iso_option.lower()}_{curve_option.lower()}.csv",mime="text/csv")



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
                        group_col = "Month" if view_option == "Monthly" else "He"
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
                        # if show_data_table:
                        #     pivot_data = avg_df.pivot(index=group_col, columns="zone", values="value")
                        #     st.dataframe(pivot_data.style.format("{:.6f}"), use_container_width=True)
                        if show_data_table:
                            st.markdown("#### Preview of Processed Data")
                            
                            sorted_df = st.session_state["nyiso_processed_df"].sort_values(
                                by=["Month", "He", "Block Type"]
                            ).reset_index(drop=True)

                            st.dataframe(sorted_df, use_container_width=True)
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
                            <div class="zone-card">
                                <strong>{zone}</strong> 
                                <div>
                                    VLR: <code>{avg_vlrs[zone]*100:.4f}%</code> 
                                    ABS: <code>{zone_settings[zone]['abs']}</code> 
                                    Scaler: <code>{zone_settings[zone]['scaler']*100:.0f}%</code>
                                </div>
                            </div>
                            """, unsafe_allow_html=True)
                        #st.markdown(f"""
                        #<div style="background-color:#f0f2f6; padding:10px; border-radius:5px; margin-bottom:5px;">
                         #   <strong>{zone}</strong> - 
                          #  VLR: <code>{avg_vlrs[zone]*100:.4f}%</code> | 
                           # ABS: <code>{zone_settings[zone]['abs']}</code> | 
                            #Scaler: <code>{zone_settings[zone]['scaler']*100:.0f}%</code>
                        #</div>
                        #""", unsafe_allow_html=True)
                    
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
# 📚 Define All Tables (Shaping, VLR, Hierarchies)
with tab3:
    st.header("Data Viewer")

    # 🔗 Database Connection
    # engine = create_engine("postgresql+psycopg2://postgres:postgres@localhost:5432/trueprice")

    # 🔥 Organized ISO -> Categories -> Tables Mapping
    ISO_TABLES = {
        "ERCOT": {
            "Shaping": {
                "Shaping DA LMPS": ("ercot_shaping_da_lmps", "da_lmps_hierarchy"),
                "Shaping DA LMPS AVG": ("ercot_shaping_da_lmps_avg", "da_lmps_avg_ercot_hierarchy"),
                "Shaping": ("ercot_shaping", "ercot_hierarchy"),
            },
            "VLR": {
                "Hourly Cost": ("ercot_vlr_hourly_cost", "ercot_vlr_hourly_cost_hierarchy"),
                "Unitized Cost": ("ercot_vlr_unitized_cost", "ercot_vlr_unitized_cost_hierarchy"),
                "VLR": ("ercot_vlr", "ercot_vlr_hierarchy"),
                "Total Price w/ Imbalance": ("ercot_vlr_tot_pricewimbalance", "ercot_vlr_tot_pricewimbalance_hierarchy"),
                "Total Hedge Cost w/ Imbalance": ("ercot_vlr_tot_hedgecostwimbalance", "ercot_vlr_tot_hedgecostwimbalance_hierarchy"),
                "Total Hedge Cost wo/ Imbalance": ("ercot_vlr_tot_hedgecostwoimbalance", "ercot_vlr_tot_hedgecostwoimbalance_hierarchy"),
                "Total Cost of Imbalance": ("ercot_tot_costofimbalance", "ercot_tot_costofimbalance_hierarchy"),
            },
            "LMPS": {
                "DA LMPS": ("da_lmps_ercot", "da_lmps_ercot_hierarchy"),
                "RT LMPS": ("rt_lmps_ercot", "rt_lmps_ercot_hierarchy"),
                "DA WZ LMPS": ("da_wz_ercot", "da_wz_ercot_hierarchy"),
                "RT WZ LMPS": ("rt_wz_ercot", "rt_wz_ercot_hierarchy"),
            },
            "Load": {
                "DA Load": ("da_load_ercot", "da_load_ercot_hierarchy"),
                "RT Load": ("rt_load_ercot", "rt_load_ercot_hierarchy"),
            },
            "Variance": {
                "Price Variance": ("price_variance_ercot", "price_var_ercot_hierarchy"),
                "Load Variance": ("load_variance_ercot", "load_var_ercot_hierarchy"),
            },
        },
        # mappings for ISONE, NYISO, PJM, MISO here easily
    }

    # Streamlit UI
    iso_selected = st.selectbox("Select ISO", list(ISO_TABLES.keys()))

    if iso_selected:
        category_selected = st.selectbox("Select Category", list(ISO_TABLES[iso_selected].keys()))
        if category_selected:
            table_options = ISO_TABLES[iso_selected][category_selected]
            table_selected_label = st.selectbox("Select Table", list(table_options.keys()))
            table_selected, hierarchy_table = table_options[table_selected_label]

            if st.button("📥 Load Table & Hierarchy"):
                try:
                    with engine.connect() as conn:
                        df = pd.read_sql(f"SELECT * FROM public.{table_selected}", conn)
                        st.subheader(f"📄 Data: {table_selected}")
                        st.dataframe(df, use_container_width=True)

                        # 📥 Download main table
                        towrite = BytesIO()
                        df.to_csv(towrite, index=False)
                        towrite.seek(0)
                        st.download_button(
                            label=f"Download {table_selected}.csv",
                            data=towrite,
                            file_name=f"{table_selected}.csv",
                            mime="text/csv"
                        )

                        # Foreign Key (Hierarchy) Table
                        df_hierarchy = pd.read_sql(f"SELECT * FROM public.{hierarchy_table}", conn)
                        st.subheader(f"🔗 Foreign Key Table: {hierarchy_table}")
                        st.dataframe(df_hierarchy, use_container_width=True)

                        # 📥 Download foreign key table
                        towrite_fk = BytesIO()
                        df_hierarchy.to_csv(towrite_fk, index=False)
                        towrite_fk.seek(0)
                        st.download_button(
                            label=f"Download {hierarchy_table}.csv",
                            data=towrite_fk,
                            file_name=f"{hierarchy_table}.csv",
                            mime="text/csv"
                        )
                except Exception as e:
                    st.error(f"❗ Error loading table: {e}")
        # 🧩 --- New Advanced Options --- 🧩
    # Insert new row
    with st.expander("➕ Insert New Row"):
        st.info("Fill all columns to insert a new row.")
        try:
            with engine.connect() as conn:
                df_columns = pd.read_sql(f"SELECT * FROM public.{table_selected} LIMIT 0", conn).columns.tolist()
            new_data = {}
            for col in df_columns:
                new_data[col] = st.text_input(f"Enter {col}")
            if st.button("✅ Insert Row"):
                columns = ', '.join(new_data.keys())
                values = "', '".join(new_data.values())
                insert_query = f"INSERT INTO public.{table_selected} ({columns}) VALUES ('{values}')"
                with engine.begin() as conn:
                    conn.execute(text(insert_query))
                st.success("Row inserted successfully! 🎯")
        except Exception as e:
            st.error(f"❗ Error inserting: {e}")

    # Delete row
    with st.expander("🗑️ Delete Row"):
        delete_id = st.text_input("Enter ID to delete (primary key id)")
        if st.button("❌ Delete Row"):
            try:
                with engine.begin() as conn:
                    conn.execute(text(f"DELETE FROM public.{table_selected} WHERE id = {delete_id}"))
                st.success(f"Deleted row with id={delete_id}")
            except Exception as e:
                st.error(f"❗ Error deleting: {e}")

    # Update row
    with st.expander("✏️ Update Row"):
        update_id = st.text_input("Enter ID to update")
        update_column = st.text_input("Enter column name to update")
        update_value = st.text_input("Enter new value")
        if st.button("✏️ Update Row Now"):
            try:
                with engine.begin() as conn:
                    conn.execute(text(f"UPDATE public.{table_selected} SET {update_column} = '{update_value}' WHERE id = {update_id}"))
                st.success(f"Updated row id={update_id}")
            except Exception as e:
                st.error(f"❗ Error updating: {e}")
