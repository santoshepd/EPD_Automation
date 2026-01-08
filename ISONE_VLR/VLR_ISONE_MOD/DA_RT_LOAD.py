import os
from dotenv import load_dotenv
import requests
import pandas as pd
import psycopg2
from io import StringIO
from datetime import datetime, timedelta
from psycopg2.extras import execute_values

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

RT_LOAD_MAPPING = {
    "NEI00009700004001": 2, "NEI00009700004002": 4, "NEI00009700004003": 7,
    "NEI00009700004004": 1, "NEI00009700004005": 5, "NEI00009700004006": 6,
    "NEI00009700004007": 8, "NEI00009700004008": 3
}

DA_LOAD_MAPPING = {
    "NEI00000500004001": 2, "NEI00000500004002": 4, "NEI00000500004003": 7,
    "NEI00000500004004": 1, "NEI00000500004005": 5, "NEI00000500004006": 6,
    "NEI00000500004007": 8, "NEI00000500004008": 3
}

DAY_TYPE_MAPPING = {
    1: "WeekEnd", 2: "WeekDay", 3: "WeekDay", 4: "WeekDay",
    5: "WeekDay", 6: "WeekDay", 7: "WeekEnd"
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
            print(f"Database is empty. Using default start date: 2020-12-01")
            return datetime(2020, 12, 1)
        else:
            next_date = last_date + timedelta(days=1)
            print(f"Found last date: {last_date}. Start from {next_date.strftime('%Y-%m-%d')}")
            return next_date

    except Exception as e:
        print(f" Error fetching last date: {e}. Using default 2020-01-01")
        return datetime(2020, 12, 1)

start_date = get_last_date("rt_load_isone")
# end_date = datetime(2024, 2, 28)
# end_date = datetime(2025,2,28)
end_date = datetime(2025,5,15)


print(f"Fetching data from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}")

def fetch_data(symbol_mapping):
    all_data = []
    for symbol, hierarchy_id in symbol_mapping.items():
        print(f"Fetching data for {symbol} (Hierarchy ID: {hierarchy_id})...")

        url = (f"https://webservice.gvsi.com/api/v3/getintraday?"
               f"symbols=%23{symbol}&fields=close%2Ctradedatetimeutc&output=csv&includeheaders=true"
               f"&startdate={start_date.strftime('%m/%d/%Y')}&enddate={end_date.strftime('%m/%d/%Y')}"
               f"&aggregatetype=0&intradaybarinterval=60&timezone=publisher")

        print(f"🔹 Requesting API from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}")

        response = requests.get(url, headers=headers, timeout=90)

        if response.status_code == 200:
            print(f"API response received for {symbol}. First 500 characters:\n{response.text[:500]}")
            df = pd.read_csv(StringIO(response.text))

            df['datetime'] = pd.to_datetime(df['tradedatetimeutc'], format='%m/%d/%Y %I:%M:%S %p')
            df['date'] = df['datetime'].dt.strftime('%Y-%m-%d')
            df['he'] = df['datetime'].dt.hour + 1
            df['data'] = df['close']
            df['hierarchy_id'] = hierarchy_id
            df['year'] = pd.to_datetime(df['date']).dt.year
            df['month'] = pd.to_datetime(df['date']).dt.month
            df['day'] = pd.to_datetime(df['date']).apply(lambda x: x.isoweekday() % 7 + 1)
            df['day_type'] = df['day'].map(DAY_TYPE_MAPPING)
            # df['hour_type'] = df['he'].apply(lambda x: "OnPeak" if 7 <= x <= 22 else "OffPeak")
            df["hour_type"] = df["he"].apply(lambda x: "OnPeak" if 8 <= x <= 23 else "OffPeak")

            def calculate_block_type(row):
                if row["day_type"] == "WeekDay" and row["hour_type"] == "OnPeak":
                    return "5x16"
                elif row["day_type"] == "WeekEnd" and row["hour_type"] == "OnPeak":
                    return "2x16"
                else:
                    return "7x8"

            df['block_type'] = df.apply(calculate_block_type, axis=1)
            df = df[['hierarchy_id', 'date', 'year', 'month', 'day', 'day_type', 'he', 'hour_type', 'block_type', 'data']]
            all_data.append(df)
        else:
            print(f"Failed to fetch data for {symbol}. HTTP Status: {response.status_code}")
    return pd.concat(all_data, ignore_index=True) if all_data else pd.DataFrame()

RT_LOAD = fetch_data(RT_LOAD_MAPPING)
DA_LOAD = fetch_data(DA_LOAD_MAPPING)

def insert_data_to_db(df, table_name):
    if df.empty:
        print(f" No new data to insert for {table_name}.")
        return
    try:
        df = df.drop_duplicates(subset=['hierarchy_id', 'date', 'he'], keep='last')
        df = df.astype(object)

        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()

        columns = ['hierarchy_id', 'date', 'year', 'month', 'day',
                   'day_type', 'he', 'hour_type', 'block_type', 'data']
        values = df[columns].values.tolist()

        insert_query = f"""
        INSERT INTO {table_name} ({', '.join(columns)})
        VALUES %s
        ON CONFLICT (hierarchy_id, date, he)
        DO UPDATE SET data = EXCLUDED.data
        """

        execute_values(cursor, insert_query, values)
        conn.commit()
        cursor.close()
        conn.close()

        print(f"Data inserted successfully into {table_name}!")

    except Exception as e:
        print(f"Error inserting data into {table_name}: {e}")

insert_data_to_db(RT_LOAD, "rt_load_isone")
insert_data_to_db(DA_LOAD, "da_load_isone")

print("Process completed successfully!")
