import os
from dotenv import load_dotenv
import requests
import pandas as pd
import psycopg2
from io import StringIO
from datetime import datetime, timedelta

load_dotenv(override=True)  # <-- MAKE SURE this line exists and has override=True

DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}
print("DB Name:", os.getenv("DB_NAME"))
print("DB User:", os.getenv("DB_USER"))
print("DB Password is set:", bool(os.getenv("DB_PASSWORD"))) 
print("DB_PASSWORD:", os.getenv("DB_PASSWORD"))  # REMOVE after debugging
print("DB Host:", os.getenv("DB_HOST"))
print("DB Port:", os.getenv("DB_PORT"))
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

# Determine the date range for data fetching
start_date = get_last_date("nyiso_vlr_rt_lmps")
# end_date = datetime(2024, 6, 30)
# end_date = datetime(2025,2,28)
end_date = datetime(2025,5,15)

# end_date = datetime.now() - timedelta(days=1)


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
    
    
# -----------------------
# NYISO Symbol → Hierarchy ID Mapping
# -----------------------

RT_LMPS_MAPPING = {
    "NYI00002300061757": 1,
    "NYI00002300061754": 2,
    "NYI00002300061760": 3,
    "NYI00002300061753": 4,
    "NYI00002300061758": 5,
    "NYI00002300061762": 6,
    "NYI00002300061756": 7,
    "NYI00002300061759": 8,
    "NYI00002300061761": 9,
    "NYI00002300061755": 10,
    "NYI00002300061752": 11,
}

DA_LMPS_MAPPING = {
    "NYI00002900061757": 1,
    "NYI00002900061754": 2,
    "NYI00002900061760": 3,
    "NYI00002900061753": 4,
    "NYI00002900061758": 5,
    "NYI00002900061762": 6,
    "NYI00002900061756": 7,
    "NYI00002900061759": 8,
    "NYI00002900061761": 9,
    "NYI00002900061755": 10,
    "NYI00002900061752": 11,
}


# Fetch Real-Time and Day-Ahead LMPS
RT_LMPS = fetch_data(RT_LMPS_MAPPING)
DA_LMPS = fetch_data(DA_LMPS_MAPPING)


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

insert_data_to_db(RT_LMPS, "nyiso_vlr_rt_lmps")
insert_data_to_db(DA_LMPS, "nyiso_vlr_da_lmps")
