import os
from dotenv import load_dotenv
import requests
import pandas as pd
from io import StringIO
from datetime import datetime, timedelta
import psycopg2
import psycopg2.extras

# Load environment variables
load_dotenv(override=True)

DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}

headers = {
    'Authorization': 'Basic VFJVRUFQSTphM3dTYVVSVA=='  
}

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
            print("Database is empty. Using default start date: 2020-12-01")
            return datetime(2020, 12, 1)
        else:
            next_date = last_date + timedelta(days=1)
            print(f"Found last date: {last_date}. Start from {next_date.strftime('%Y-%m-%d')}")
            return next_date  

    except Exception as e:
        print(f"Error fetching last date: {e}. Using default 2020-12-01")
        return datetime(2020, 12, 1)  

def fetch_data(symbol_mapping):
    all_data = []

    for symbol, hierarchy_id in symbol_mapping.items():
        print(f"Fetching data for {symbol} (Hierarchy ID: {hierarchy_id})...")

        url = (f"https://webservice.gvsi.com/api/v3/getintraday?"
               f"symbols=%23{symbol}&fields=close%2Ctradedatetimeutc&output=csv&includeheaders=true"
               f"&startdate={start_date.strftime('%m/%d/%Y')}&enddate={end_date.strftime('%m/%d/%Y')}"
               f"&aggregatetype=0&intradaybarinterval=60&timezone=publisher")

        print(f"🔹 Requesting API from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}")

        response = requests.get(url, headers=headers,timeout=90)

        if response.status_code == 200:
            df = pd.read_csv(StringIO(response.text))
            df['datetime'] = pd.to_datetime(df['tradedatetimeutc'], format='%m/%d/%Y %I:%M:%S %p')
            df['date'] = df['datetime'].dt.strftime('%Y-%m-%d')
            df['he'] = df['datetime'].dt.hour + 1
            df['data'] = df['close']
            df['hierarchy_id'] = hierarchy_id

            df = df[['hierarchy_id', 'date', 'he', 'data']]
            all_data.append(df)
        else:
            print(f"❌ Failed to fetch data for {symbol}. HTTP Status: {response.status_code}")

    if all_data:
        return pd.concat(all_data, ignore_index=True)
    else:
        return pd.DataFrame()

# -----------------------
# NYISO Symbol → Hierarchy ID Mapping
# -----------------------
NYISO_DA_LOAD_MAPPING = {
    "NYI00004500061757": 1, "NYI00004500061754": 2, "NYI00004500061760": 3,
    "NYI00004500061753": 4, "NYI00004500061758": 5, "NYI00004500061762": 6,
    "NYI00004500061756": 7, "NYI00004500061759": 8, "NYI00004500061761": 9,
    "NYI00004500061755": 10, "NYI00004500061752": 11
}

NYISO_RT_LOAD_MAPPING = {
    "NYI00003600061757": 1, "NYI00003600061754": 2, "NYI00003600061760": 3,
    "NYI00003600061753": 4, "NYI00003600061758": 5, "NYI00003600061762": 6,
    "NYI00003600061756": 7, "NYI00003600061759": 8, "NYI00003600061761": 9,
    "NYI00003600061755": 10, "NYI00003600061752": 11
}

# -----------------------
# MAIN EXECUTION
# -----------------------

start_date = get_last_date("nyiso_vlr_rt_load")
# end_date = datetime(2024, 6, 30)
# end_date = datetime(2025,2,28)
end_date = datetime(2025,5,15)

# end_date = (datetime.now() - timedelta(days=1)).replace(hour=0, minute=0, second=0, microsecond=0)

print(f"\n📦 Fetching NYISO data from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}\n")

RT_LOAD = fetch_data(NYISO_RT_LOAD_MAPPING)
DA_LOAD = fetch_data(NYISO_DA_LOAD_MAPPING)

def insert_data_to_db(df, table_name):
    if df.empty:
        print(f"⚠ No new data to insert for {table_name}.")
        return

    try:
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()

        for _, row in df.iterrows():
            insert_query = f"""
                INSERT INTO {table_name} (hierarchy_id, date, he, data)
                VALUES (%s, %s, %s, %s)
                ON CONFLICT (hierarchy_id, date, he)
                DO NOTHING;
            """
            cursor.execute(insert_query, (row['hierarchy_id'], row['date'], row['he'], row['data']))

        conn.commit()
        cursor.close()
        conn.close()
        print(f" Data inserted successfully into {table_name} (duplicates skipped)!")
        
    except Exception as e:
        print(f" Error inserting data into {table_name}: {e}")


insert_data_to_db(RT_LOAD, "nyiso_vlr_rt_load")
insert_data_to_db(DA_LOAD, "nyiso_vlr_da_load")
