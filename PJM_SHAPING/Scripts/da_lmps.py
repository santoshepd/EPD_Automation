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

# PJM DA_LMPS Symbol Mapping 
PJM_DA_LMPS_MAPPING = {
    "PJM00000156000000051291": 1,  # AECO
    "PJM00000156000008445784": 2,  # AEP
    "PJM00000156000008394954": 3,  # APS
    "PJM00000156000116013753": 4,  # ATSI
    "PJM00000156000000051292": 5,  # BGE
    "PJM00000156000033092371": 6,  # COMED
    "PJM00000156000034508503": 7,  # DAY
    "PJM00000156000124076095": 8,  # DEOK
    "PJM00000156000034964545": 9,  # DOM
    "PJM00000156000000051293": 10, # DPL
    "PJM00000156000037737283": 11, # DUQ
    "PJM00000156000000051295": 12, # JCPL
    "PJM00000156000000051296": 13, # METED
    "PJM00000156000000051297": 14, # PECO
    "PJM00000156000000051300": 15, # PENELEC
    "PJM00000156000000051298": 16, # PEPCO
    "PJM00000156000000051299": 17, # PPL
    "PJM00000156000000051301": 18, # PSEG
    "PJM00000156000007633629": 19  # RECO
}

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
        cursor.execute("SELECT MAX(date) FROM da_lmps_pjm_sh;")
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
#start_date = datetime(2020,01,01)
#end_date = datetime.today() - timedelta(days=1)  # Ensure end_date is yesterday
# end_date = datetime(2024, 6, 30)
# end_date = datetime(2025,4,10)
end_date = datetime(2025,5,15)

print(f"Fetching data from {start_date.strftime('%Y-%m-%d')} to {end_date.strftime('%Y-%m-%d')}")

# Fetch Data from API for PJM DA_LMPS
def fetch_pjm_da_lmps_data(symbol_mapping):
    all_data = []
    
    for symbol, hierarchy_id in symbol_mapping.items():
        print(f"Fetching data for {symbol} (Hierarchy ID: {hierarchy_id})...")

        url = (f"https://webservice.gvsi.com/api/v3/getintraday?symbols=%23{symbol}&fields=close%2Ctradedatetimeutc&output=csv&includeheaders=true"
               f"&startdate={start_date.strftime('%m/%d/%Y')}&enddate={end_date.strftime('%m/%d/%Y')}"
               f"&aggregatetype=0&intradaybarinterval=60&timezone=publisher")

        response = requests.get(url, headers=HEADERS,timeout=90)

        if response.status_code == 200:
            print(f"API response received for {symbol}")
            df = pd.read_csv(StringIO(response.text))
            df['datetime'] = pd.to_datetime(df['tradedatetimeutc'], format='%m/%d/%Y %I:%M:%S %p')
            df['date'] = df['datetime'].dt.date  # Convert to YYYY-MM-DD
            df['he'] = df['datetime'].dt.hour + 1  # Convert to HE (Hour Ending)
            df['data'] = df['close']
            df['hierarchy_id'] = hierarchy_id  
            df['year'] = pd.to_datetime(df['date']).dt.year
            df['month'] = pd.to_datetime(df['date']).dt.month
            df['day'] = pd.to_datetime(df['date']).apply(lambda x: x.isoweekday() % 7 + 1)
            df['day_type'] = df['day'].map(DAY_TYPE_MAPPING)
            df['hour_type'] = df['he'].apply(lambda x: "OnPeak" if 7 <= x <= 22 else "OffPeak")
            
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

df_pjm_da_lmps = fetch_pjm_da_lmps_data(PJM_DA_LMPS_MAPPING)

if not df_pjm_da_lmps.empty:
    conn = psycopg2.connect(**DB_PARAMS)
    cursor = conn.cursor()

    cursor.executemany("""
        INSERT INTO da_lmps_pjm_sh
        (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
        VALUES (%(hierarchy_id)s, %(date)s, %(year)s, %(month)s, %(day)s, %(day_type)s, %(he)s, %(hour_type)s, %(block_type)s, %(data)s)
        ON CONFLICT (hierarchy_id, date, he) 
        DO UPDATE SET data = EXCLUDED.data
    """, df_pjm_da_lmps.to_dict(orient="records"))

    conn.commit()
    cursor.close()
    conn.close()
    
    print("Data inserted into `da_lmps_pjm` successfully!")

else:
    print("No new data fetched from API for `da_lmps_pjm`")

print("Process completed successfully!")
