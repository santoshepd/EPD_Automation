import os
from dotenv import load_dotenv
import requests
import pandas as pd
import psycopg2
from io import StringIO
from datetime import datetime, timedelta

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
            print("Database is empty. Using default start date: 2020-01-01")
            return datetime(2020, 12, 1)
        else:
            next_date = last_date + timedelta(days=1)
            print(f"Found last date: {last_date}. Start from {next_date.strftime('%Y-%m-%d')}")
            return next_date

    except Exception as e:
        print(f"Error fetching last date: {e}. Using default 2020-01-01")
        return datetime(2020, 12, 1)
start_date = get_last_date("pjm_vlr_rt_lmps")
# end_date = datetime(2025,4,30)
end_date = datetime(2025,5,15)

# end_date = datetime(2021, 12, 1)

print(f"Fetching data from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}")
def fetch_data(symbol_mapping):
    all_data = []

    for symbol, hierarchy_id in symbol_mapping.items():
        print(f"Fetching data for {symbol} (Hierarchy ID: {hierarchy_id})...")

        url = (
            f"https://webservice.gvsi.com/api/v3/getintraday?"
            f"symbols=%23{symbol}&fields=close%2Ctradedatetimeutc&output=csv&includeheaders=true"
            f"&startdate={start_date.strftime('%m/%d/%Y')}&enddate={end_date.strftime('%m/%d/%Y')}"
            f"&aggregatetype=0&intradaybarinterval=60&timezone=publisher"
        )
        print(f"Requesting API from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}")

        response = requests.get(url, headers=headers,timeout=90)

        if response.status_code == 200:
            print(f"API response received for {symbol}. First 100 characters:\\n{response.text[:100]}")
            df = pd.read_csv(StringIO(response.text))

            df['datetime'] = pd.to_datetime(df['tradedatetimeutc'], format='%m/%d/%Y %I:%M:%S %p')
            df['date'] = df['datetime'].dt.strftime('%Y-%m-%d')
            df['he'] = df['datetime'].dt.hour + 1
            df['data'] = df['close']
            df['hierarchy_id'] = hierarchy_id

            df = df[['hierarchy_id', 'date', 'he', 'data']]
            all_data.append(df)
        else:
            print(f"Failed to fetch data for {symbol}. HTTP Status: {response.status_code}")

    if all_data:
        return pd.concat(all_data, ignore_index=True)
    else:
        return pd.DataFrame()
    
PJM_RT_LMPS_MAPPING = {
    "PJM00000154000000051291": 1,  # AECO
    "PJM00000154000008445784": 2,  # AEP  
    "PJM00000154000008394954": 3,  # APS    
    "PJM00000154000116013753": 4,  # ATSI
    "PJM00000154000000051292": 5,  # BGE
    "PJM00000154000033092371": 6,  # COMED
    "PJM00000154000034508503": 7,  # DAY
    "PJM00000154000124076095": 8,  # DEOK
    "PJM00000154000034964545": 9,  # DOM
    "PJM00000154000000051293": 10, # DPL
    "PJM00000154000037737283": 11, # DUQ
    "PJM00000154000000051295": 12, # JCPL
    "PJM00000154000000051296": 13, # METED
    "PJM00000154000000051297": 14, # PECO
    "PJM00000154000000051300": 15, # PENELEC
    "PJM00000154000000051298": 16, # PEPCO
    "PJM00000154000000051299": 17, # PPL
    "PJM00000154000000051301": 18, # PSEG
    "PJM00000154000007633629": 19  # RECO
}

# Mapping for Day-Ahead LMPs
PJM_DA_LMPS_MAPPING = {
    "PJM00000156000000051291": 1,  
    "PJM00000156000008445784": 2,  
    "PJM00000156000008394954": 3,  
    "PJM00000156000116013753": 4,  
    "PJM00000156000000051292": 5,  
    "PJM00000156000033092371": 6,  
    "PJM00000156000034508503": 7,  
    "PJM00000156000124076095": 8,  
    "PJM00000156000034964545": 9,  
    "PJM00000156000000051293": 10, 
    "PJM00000156000037737283": 11, 
    "PJM00000156000000051295": 12, 
    "PJM00000156000000051296": 13, 
    "PJM00000156000000051297": 14, 
    "PJM00000156000000051300": 15, 
    "PJM00000156000000051298": 16, 
    "PJM00000156000000051299": 17, 
    "PJM00000156000000051301": 18, 
    "PJM00000156000007633629": 19  
}
RT_LMPS = fetch_data(PJM_RT_LMPS_MAPPING)
DA_LMPS = fetch_data(PJM_DA_LMPS_MAPPING)

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
        print(f"Data inserted successfully into {table_name} (duplicates skipped)!")
        
    except Exception as e:
        print(f"Error inserting data into {table_name}: {e}")

insert_data_to_db(RT_LMPS, "pjm_vlr_rt_lmps")
insert_data_to_db(DA_LMPS, "pjm_vlr_da_lmps")
