import os
from dotenv import load_dotenv
import requests
import pandas as pd
import psycopg2
from io import StringIO
from datetime import datetime, timedelta
from concurrent.futures import ThreadPoolExecutor, as_completed

# Load environment variables
load_dotenv()

DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD") or "postgres",
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}

print("DB Name:", os.getenv("DB_NAME"))
print("DB User:", os.getenv("DB_USER"))
print("DB Password is set:", bool(os.getenv("DB_PASSWORD"))) 
print("DB Host:", os.getenv("DB_HOST"))
print("DB Port:", os.getenv("DB_PORT"))

headers = {
    'Authorization': 'Basic VFJVRUFQSTphM3dTYVVSVA=='  
}

def get_last_date(table_name):
    try:
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()
        cursor.execute(f"SELECT MAX(date) FROM public.{table_name};")
        last_date = cursor.fetchone()[0]
        cursor.close()
        conn.close()

        if last_date is None:
            print("Database is empty. Using default start date: 2020-01-01")
            return datetime(2020, 12, 1)
        else:
            next_date = last_date + timedelta(days=1)
            print(f"Found last date: {last_date}. Start from {next_date.strftime('%Y-%m-%d')}")
            return next_date
    except Exception as e:
        print(f"Error fetching last date: {e}. Using default 2020-01-01")
        return datetime(2020, 12, 1)

# Date range
start_date = get_last_date("rt_lmps_ercot")
end_date = datetime(2025,5,15)

print(f"Fetching data from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}")

# Fetch single symbol data
def fetch_single_symbol(symbol, hierarchy_id):
    try:
        print(f"Fetching data for {symbol} (Hierarchy ID: {hierarchy_id})...")

        url = (
            f"https://webservice.gvsi.com/api/v3/getintraday?"
            f"symbols=%23{symbol}&fields=close%2Ctradedatetimeutc&output=csv&includeheaders=true"
            f"&startdate={start_date.strftime('%m/%d/%Y')}&enddate={end_date.strftime('%m/%d/%Y')}"
            f"&aggregatetype=0&intradaybarinterval=60&timezone=publisher"
        )

        response = requests.get(url, headers=headers, timeout=300)

        if response.status_code == 200:
            df = pd.read_csv(StringIO(response.text))
            df['datetime'] = pd.to_datetime(df['tradedatetimeutc'], format='%m/%d/%Y %I:%M:%S %p')
            df['date'] = df['datetime'].dt.strftime('%Y-%m-%d')
            df['he'] = df['datetime'].dt.hour + 1
            df['data'] = df['close']
            df['hierarchy_id'] = hierarchy_id
            return df[['hierarchy_id', 'date', 'he', 'data']]
        else:
            print(f"Failed to fetch {symbol}. HTTP Status: {response.status_code}")
            return pd.DataFrame()
    except Exception as e:
        print(f"Error fetching {symbol}: {e}")
        return pd.DataFrame()

# Fetch data for a mapping
def fetch_data_parallel(symbol_mapping):
    all_data = []
    with ThreadPoolExecutor(max_workers=4) as executor:  # You can increase max_workers if server allows
        futures = [executor.submit(fetch_single_symbol, symbol, hierarchy_id)
                   for symbol, hierarchy_id in symbol_mapping.items()]
        
        for future in as_completed(futures):
            df = future.result()
            if not df.empty:
                all_data.append(df)

    if all_data:
        return pd.concat(all_data, ignore_index=True)
    else:
        return pd.DataFrame()

# Fetching Data for RT and DA LMPS
RT_LMPS_MAPPING = {
    "ERC00000002000000005319": 1, #North
    "ERC00000002000000000065": 2, #Houston  
    "ERC00000002000000004665": 3, #South    
    "ERC00000002000000008060": 4  #West
}

DA_LMPS_MAPPING = {
    "ERC00000016000000005319": 1, 
    "ERC00000016000000000065": 2, 
    "ERC00000016000000004665": 3, 
    "ERC00000016000000008060": 4 
}

RT_LMPS = fetch_data_parallel(RT_LMPS_MAPPING)
DA_LMPS = fetch_data_parallel(DA_LMPS_MAPPING)

# Insert Data
def insert_data_to_db(df, table_name):
    if df.empty:
        print(f"⚠ No new data to insert for {table_name}.")
        return

    try:
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()

        for _, row in df.iterrows():
            cursor.execute(
                f"""
                INSERT INTO {table_name} (hierarchy_id, date, he, data)
                VALUES (%s, %s, %s, %s)
                ON CONFLICT (hierarchy_id, date, he)
                DO UPDATE SET data = EXCLUDED.data;
                """,
                (row['hierarchy_id'], row['date'], row['he'], row['data'])
            )

        conn.commit()
        cursor.close()
        conn.close()
        print(f"Data inserted successfully into {table_name}!")
    except Exception as e:
        print(f"Error inserting into {table_name}: {e}")


# Insert the fetched data into the database
insert_data_to_db(RT_LMPS, "rt_lmps_ercot")
insert_data_to_db(DA_LMPS, "da_lmps_ercot")

print("Process completed successfully!")
