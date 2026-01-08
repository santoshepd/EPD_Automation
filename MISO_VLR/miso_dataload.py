import requests
import pandas as pd
from io import StringIO
from datetime import datetime, timedelta
import psycopg2
import psycopg2.extras

DB_PARAMS = {
    "dbname": "trueprice",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": "5432"
}
headers = {
    'Authorization': 'Basic VFJVRUFQSTphM3dTYVVSVA=='  
}

# -----------------------
# GET LAST DATE FROM DB
# -----------------------

def get_last_date(table_name):
    try:
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()
        query = f"SELECT MAX(date) FROM public.{table_name};"
        cursor.execute(query)
        last_date = cursor.fetchone()[0] 
        cursor.close()
        conn.close()

        if last_date is None:
            print(f"Database is empty. Using default start date: 2020-12-01")
            return datetime(2020, 12, 1)
        else:
            next_date = last_date + timedelta(days=1)
            print(f"Found last date: {last_date}. Start from {next_date.strftime('%Y-%m-%d')}")
            return next_date  

    except Exception as e:
        print(f"Error fetching last date: {e}. Using default 2020-12-01")
        return datetime(2020, 12, 1)  

# -----------------------
# FETCH DATA
# -----------------------

def fetch_data(symbol_mapping):
    all_data = []

    for symbol, hierarchy_id in symbol_mapping.items():
        print(f"Fetching data for {symbol} (Hierarchy ID: {hierarchy_id})...")


        url = (f"https://webservice.gvsi.com/api/v3/getintraday?"
                f"symbols=%23{symbol}&fields=close%2Ctradedatetimeutc&output=csv&includeheaders=true"
                f"&startdate={start_date.strftime('%m/%d/%Y')}&enddate={end_date.strftime('%m/%d/%Y')}"
                f"&aggregatetype=0&intradaybarinterval=60&timezone=publisher")

        print(f"🔹 Requesting API from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}")

        response = requests.get(url, headers=headers, timeout=300)

        if response.status_code == 200:
            # print(f"API response received for {symbol}. First 500 characters:\n{response.text[:500]}")
            df = pd.read_csv(StringIO(response.text))
            

            df['datetime'] = pd.to_datetime(df['tradedatetimeutc'], format='%m/%d/%Y %I:%M:%S %p')
            df['date'] = df['datetime'].dt.strftime('%Y-%m-%d')  # Convert to YYYY-MM-DD
            df['he'] = df['datetime'].dt.hour + 1  # Convert to HE (Hour Ending)
            df['data'] = df['close']
            df['hierarchy_id'] = hierarchy_id  # Assign hierarchy ID

            df = df[['hierarchy_id', 'date', 'he', 'data']]
            
            all_data.append(df)
        else:
            print(f"Failed to fetch data for {symbol}. HTTP Status: {response.status_code}")

    if all_data:
        return pd.concat(all_data, ignore_index=True)
    else:
        return pd.DataFrame()


# -----------------------
# SYMBOL MAPPINGS
# -----------------------

MISO_RT_LMPS_MAPPING = {
    "MIS00006400002167": 1,  # AMIL.CILC.BOC
    "MIS00006400002173": 2,  # AMIL.CIPS
    "MIS00006400002223": 3   # AMIL.IP
}

MISO_DA_LMPS_MAPPING = {
    "MIS00000700002167": 1,  # AMIL.CILC.BOC
    "MIS00000700002173": 2,  # AMIL.CIPS
    "MIS00000700002223": 3   # AMIL.IP
}
def insert_data_to_db_new(df, table_name):
    if df.empty:
        print(f"⚠ No new data to insert for {table_name}.")
        return

    try:
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()
        
        # Prepare the INSERT statement with ON CONFLICT DO NOTHING
        insert_query = f"""
        INSERT INTO {table_name} (hierarchy_id, date, he, data) 
        VALUES %s
        ON CONFLICT (hierarchy_id, date, he) DO NOTHING;
        """

        # Convert DataFrame rows into a list of tuples
        data_tuples = [tuple(x) for x in df.to_numpy()]

        # Use execute_values for batch inserts
        psycopg2.extras.execute_values(cursor, insert_query, data_tuples)

        conn.commit()
        cursor.close()
        conn.close()
        print(f"✅ Data inserted successfully into {table_name}!")

    except Exception as e:
        print(f"❌ Error inserting data into {table_name}: {e}")

# -----------------------
# MAIN EXECUTION
# -----------------------
# start_date = get_last_date("miso_vlr_rt_load")  
start_date = datetime(2021, 1, 1)
# end_date = datetime(2025, 4, 30)
end_date = datetime(2025,5,15)


rt_data = fetch_data(MISO_RT_LMPS_MAPPING)
insert_data_to_db_new(rt_data, "miso_vlr_rt_lmps")

da_data = fetch_data(MISO_DA_LMPS_MAPPING)
insert_data_to_db_new(da_data, "miso_vlr_da_lmps")

print('Working on Load Data')

da_load_df = pd.read_csv('Data_set/MISO_DA_LOAD.csv')
rt_load_df = pd.read_csv('Data_set/MISO_RT_LOAD.csv')

da_load_df=da_load_df[['interval_end_utc','lrz4_mtlf']]
rt_load_df=rt_load_df[['interval_end_utc','lrz4']]

da_load_df['interval_end_utc'] = pd.to_datetime(da_load_df['interval_end_utc'], errors='coerce')

# Safely update datetime and HE for DA Load
da_load_df.loc[:, 'he'] = da_load_df['interval_end_utc'].dt.hour + 1

# Safely update datetime and HE for RT Load
rt_load_df['interval_end_utc'] = pd.to_datetime(rt_load_df['interval_end_utc'], errors='coerce')

rt_load_df.loc[:, 'he'] = rt_load_df['interval_end_utc'].dt.hour + 1
hierarchy_ids = [1, 2, 3]

# Triplicate the DA load data for each hierarchy_id
Final_da_load_df = pd.concat(
    [da_load_df.assign(hierarchy_id=hid) for hid in hierarchy_ids],
    ignore_index=True
)


# Triplicate the DA load data for each hierarchy_id
Final_rt_load_df = pd.concat(
    [rt_load_df.assign(hierarchy_id=hid) for hid in hierarchy_ids],
    ignore_index=True
)

# Ensure datetime format for both
Final_rt_load_df['interval_end_utc'] = pd.to_datetime(Final_rt_load_df['interval_end_utc'])
Final_da_load_df['interval_end_utc'] = pd.to_datetime(Final_da_load_df['interval_end_utc'])

# Format both dataframes
Final_rt_load_df_formatted = Final_rt_load_df.assign(
    date=Final_rt_load_df['interval_end_utc'].dt.strftime('%Y-%m-%d'),
    data=Final_rt_load_df['lrz4']
)[['hierarchy_id', 'date', 'he', 'data']]

Final_da_load_df_formatted = Final_da_load_df.assign(
    date=Final_da_load_df['interval_end_utc'].dt.strftime('%Y-%m-%d'),
    data=Final_da_load_df['lrz4_mtlf']
)[['hierarchy_id', 'date', 'he', 'data']]

insert_data_to_db_new(Final_rt_load_df_formatted, "miso_vlr_rt_load")
insert_data_to_db_new(Final_da_load_df_formatted, "miso_vlr_da_load")
