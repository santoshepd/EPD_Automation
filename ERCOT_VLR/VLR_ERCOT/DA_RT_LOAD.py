#!/usr/bin/env python
import os
from dotenv import load_dotenv
import requests
import pandas as pd
import psycopg2
from io import StringIO
from datetime import datetime, timedelta
from concurrent.futures import ThreadPoolExecutor, as_completed

# Load environment variables from .env file
load_dotenv()

# Set up DB parameters from the .env file
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
        cursor.execute(f"SELECT MAX(date) FROM public.{table_name};")
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

start_date = get_last_date("rt_wz_ercot")
# end_date = datetime(2025, 2, 28)
end_date = datetime(2025,5,15)


print(f"Fetching data from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}")

# --- Fetch a single symbol ---
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
            print(f"Failed to fetch {symbol}: HTTP {response.status_code}")
            return pd.DataFrame()
    except Exception as e:
        print(f"Error fetching {symbol}: {e}")
        return pd.DataFrame()

# --- Parallel Fetch ---
def fetch_data_parallel(symbol_mapping):
    all_data = []
    with ThreadPoolExecutor(max_workers=8) as executor:
        futures = [executor.submit(fetch_single_symbol, symbol, hid) for symbol, hid in symbol_mapping.items()]
        for future in as_completed(futures):
            df = future.result()
            if not df.empty:
                all_data.append(df)
    if all_data:
        return pd.concat(all_data, ignore_index=True)
    else:
        return pd.DataFrame()

# --- Mappings ---
RT_LOAD_MAPPING = {
    "ERC00000036000000017101": 7, 
    "ERC00000036000000017140": 8, 
    "ERC00000036000000017098": 3, 
    "ERC00000036000000017099": 1, 
    "ERC00000036000000017141": 2, 
    "ERC00000036000000017142": 5, 
    "ERC00000036000000017104": 4, 
    "ERC00000036000000017105": 6 
}

DA_LOAD_MAPPING = {
    "ERC00000024000000017098": 3, 
    "ERC00000024000000017099": 1, 
    "ERC00000024000000017140": 8, 
    "ERC00000024000000017101": 7, 
    "ERC00000024000000017141": 2, 
    "ERC00000024000000017142": 5, 
    "ERC00000024000000017104": 4, 
    "ERC00000024000000017105": 6 
}

# Fetching in parallel
RT_LOAD = fetch_data_parallel(RT_LOAD_MAPPING)
DA_LOAD = fetch_data_parallel(DA_LOAD_MAPPING)

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
        print(f" Error inserting into {table_name}: {e}")

insert_data_to_db(RT_LOAD, "rt_wz_ercot")
insert_data_to_db(DA_LOAD, "da_wz_ercot")

# --- Aggregation and Insert ---
def aggregate_and_insert(region_mapping, source_table, target_table):
    try:
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()
        for region, hierarchy_ids in region_mapping.items():
            query = f"""
                INSERT INTO {target_table} (hierarchy_id, date, he, data)
                SELECT 
                    {list(region_mapping.keys()).index(region) + 1} AS hierarchy_id,
                    date, he, SUM(data) AS data
                FROM {source_table}
                WHERE hierarchy_id IN ({', '.join(map(str, hierarchy_ids))})
                GROUP BY date, he
                ON CONFLICT (hierarchy_id, date, he) DO UPDATE SET data = EXCLUDED.data;
            """
            cursor.execute(query)
        conn.commit()
        cursor.close()
        conn.close()
        print(f"Aggregated data inserted into {target_table}!")
    except Exception as e:
        print(f"Error aggregating into {target_table}: {e}")

REGION_MAPPING = {
    "North": [1, 2, 7],
    "Houston": [3],
    "South": [4, 5],
    "West": [8, 6]
}

aggregate_and_insert(REGION_MAPPING, "rt_wz_ercot", "rt_load_ercot")
aggregate_and_insert(REGION_MAPPING, "da_wz_ercot", "da_load_ercot")

print("Process completed successfully!")
