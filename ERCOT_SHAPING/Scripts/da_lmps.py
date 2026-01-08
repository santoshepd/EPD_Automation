import pandas as pd
import psycopg2
import requests
from io import StringIO
from datetime import datetime, timedelta

DB_PARAMS = {
    "dbname": "trueprice",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": "5432"
}

HEADERS = {
    'Authorization': 'Basic VFJVRUFQSTphM3dTYVVSVA==' 
}

# DA_LMPS Symbol Mapping 
DA_LMPS_MAPPING = {
    "ERC00000016000000005319": 1, #Houston
    "ERC00000016000000000065": 2, #North
    "ERC00000016000000004665": 3, #South
    "ERC00000016000000008060": 4 #West
}

# Day Mapping Based on Catalogue
DAY_TYPE_MAPPING = {
    1: "WeekEnd",  # Sunday
    2: "WeekDay",  # Monday
    3: "WeekDay",  # Tuesday
    4: "WeekDay",  # Wednesday
    5: "WeekDay",  # Thursday
    6: "WeekDay",  # Friday
    7: "WeekEnd"   # Saturday
}

# Fetching Last Available Date from Database
def get_last_date():
    try:
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()
        cursor.execute("SELECT MAX(date) FROM ercot_shaping_da_lmps;")
        last_date = cursor.fetchone()[0]
        cursor.close()
        conn.close()

        if last_date is None:
            print("No existing data found. Using default start date: 2020-12-01")
            return datetime(2020, 12, 1)
        else:
            next_date = last_date + timedelta(days=1)
            print(f"Found last date: {last_date}. Fetching data from {next_date.strftime('%Y-%m-%d')}")
            return next_date

    except Exception as e:
        print(f"Error fetching last date: {e}. Using default 2020-12-01")
        return datetime(2020, 12, 1)


start_date = get_last_date()
#end_date = datetime.today() - timedelta(days=1)  # Fetch data up to yesterday
end_date = datetime(2025,5,15)

print(f"Fetching data from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}")

# Fetch Data from API for DA_LMPS
def fetch_da_lmps_data(symbol_mapping):
    all_data = []
    
    for symbol, hierarchy_id in symbol_mapping.items():
        print(f" Fetching data for {symbol} (Hierarchy ID: {hierarchy_id})...")

        # API URL
        url = (f"https://webservice.gvsi.com/api/v3/getintraday?symbols=%23{symbol}&fields=close%2Ctradedatetimeutc&output=csv&includeheaders=true"
               f"&startdate={start_date.strftime('%m/%d/%Y')}&enddate={end_date.strftime('%m/%d/%Y')}"
               f"&aggregatetype=0&intradaybarinterval=60&timezone=publisher")

        response = requests.get(url, headers=HEADERS)

        if response.status_code == 200:
            print(f"API response received for {symbol}")
            df = pd.read_csv(StringIO(response.text))
            df['datetime'] = pd.to_datetime(df['tradedatetimeutc'], format='%m/%d/%Y %I:%M:%S %p')
            df['date'] = df['datetime'].dt.date  # Convert to YYYY-MM-DD
            df['he'] = df['datetime'].dt.hour + 1  # Convert to HE (Hour Ending)
            df['data'] = df['close']
            df['hierarchy_id'] = hierarchy_id  
            df = df[['hierarchy_id', 'date', 'he', 'data']]
            all_data.append(df)
        else:
            print(f"Failed to fetch data for {symbol}. HTTP Status: {response.status_code}")

    return pd.concat(all_data, ignore_index=True) if all_data else pd.DataFrame()

df_da_lmps = fetch_da_lmps_data(DA_LMPS_MAPPING)

if not df_da_lmps.empty:
    df_da_lmps["year"] = pd.to_datetime(df_da_lmps["date"]).dt.year
    df_da_lmps["month"] = pd.to_datetime(df_da_lmps["date"]).dt.month
    df_da_lmps["day"] = pd.to_datetime(df_da_lmps["date"]).apply(lambda x: x.isoweekday() % 7 + 1)
    df_da_lmps["day_type"] = df_da_lmps["day"].map(DAY_TYPE_MAPPING)
    df_da_lmps["hour_type"] = df_da_lmps["he"].apply(lambda x: "OnPeak" if 7 <= x <= 22 else "OffPeak")

   
    def calculate_block_type(row):
        if row["day_type"] == "WeekDay" and row["hour_type"] == "OnPeak":
            return "5x16"
        elif row["day_type"] == "WeekEnd" and row["hour_type"] == "OnPeak":
            return "2x16"
        else:
            return "7x8"

    df_da_lmps["block_type"] = df_da_lmps.apply(calculate_block_type, axis=1)

    # Insert into `ercot_shaping_da_lmps`
    conn = psycopg2.connect(**DB_PARAMS)
    cursor = conn.cursor()

    cursor.executemany("""
        INSERT INTO ercot_shaping_da_lmps 
        (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
        VALUES (%(hierarchy_id)s, %(date)s, %(year)s, %(month)s, %(day)s, %(day_type)s, %(he)s, %(hour_type)s, %(block_type)s, %(data)s)
        ON CONFLICT (hierarchy_id, date, he) 
        DO UPDATE SET data = EXCLUDED.data
    """, df_da_lmps.to_dict(orient="records"))

    conn.commit()
    cursor.close()
    conn.close()
    
    print("Data inserted into `ercot_shaping_da_lmps` successfully!")

else:
    print("No new data fetched from API for `ercot_shaping_da_lmps`")

print("Process completed successfully!")
