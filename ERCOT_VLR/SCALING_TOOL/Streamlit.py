import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
from io import BytesIO

# Set page config
st.set_page_config(page_title="ERCOT VLR Tool", layout="wide")

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

st.markdown("<div class='title-container'><h1>ERCOT VLR Data Processing Tool</h1></div>", unsafe_allow_html=True)
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
engine = create_engine(f"postgresql+psycopg2://{db_params['user']}:{db_params['password']}@{db_params['host']}:{db_params['port']}/{db_params['dbname']}")

def fetch_data():
    query_data = """
        SELECT hierarchy_id, month, he, day_type, hour_type, block_type, data 
        FROM ercot_vlr
    """  
    query_hierarchy = "SELECT * FROM vlr_hierarchy"
    
    # Load data into DataFrames
    data_df = pd.read_sql(query_data, engine)
    hierarchy_df = pd.read_sql(query_hierarchy, engine)
    
    if 'id' not in hierarchy_df.columns:
        st.error("ERROR: 'id' column is missing in vlr_hierarchy. Check database schema.")
        return None
    
    # Merge VLR data with hierarchy table
    merged_df = data_df.merge(hierarchy_df, left_on='hierarchy_id', right_on='id', how='left')
    
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
    pivot_df = fetch_data()
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

uploaded_file = st.file_uploader("Upload a file", type=["xlsx", "csv"])

if uploaded_file is None:
    st.info("Please upload a file to display and update the data.")
else:
    # Read the uploaded file
    if uploaded_file.name.endswith('.xlsx'):
        original_df = pd.read_excel(uploaded_file)
        start= 9
    else:
        original_df = pd.read_csv(uploaded_file)
        start=8
    
    # Process the DataFrame
    df = original_df.copy()
    df.columns = (
        ["control_area", "month", "he", "day_type", "hour_type", "block_type"] +
        list(df.iloc[1, 6:])
    )
    df = df.iloc[start:, 1:].reset_index(drop=True)
    
    # Display Title
    st.markdown("""
        <style>
        .title-container { text-align: center; }
        </style>
        <div class='title-container'>
            <h1>ERCOT VLR Data ABS and Scalar Converter</h1>
        </div>
    """, unsafe_allow_html=True)
    
    # Detect zone columns
    zone_columns = [col for col in df.columns if "ZONE" in col.upper()]
    
    if zone_columns:
        st.markdown("### Configure Settings for Each Zone")
        zone_settings = {}
        
        for zone in zone_columns:
            #st.markdown(f"#### Settings for {zone}")
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
