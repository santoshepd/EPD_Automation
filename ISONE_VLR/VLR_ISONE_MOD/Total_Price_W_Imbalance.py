import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine
import psycopg2

# Load environment variables
load_dotenv(override=True)

DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}

engine = create_engine(f"postgresql://{DB_PARAMS['user']}:{DB_PARAMS['password']}@{DB_PARAMS['host']}:{DB_PARAMS['port']}/{DB_PARAMS['dbname']}")

DAY_TYPE_MAPPING = {
    1: "WeekEnd",  # Sunday
    2: "WeekDay",  # Monday
    3: "WeekDay",  # Tuesday
    4: "WeekDay",  # Wednesday
    5: "WeekDay",  # Thursday
    6: "WeekDay",  # Friday
    7: "WeekEnd"   # Saturday
}

# Fetch Hedge Cost with Imbalance and RT Load Data
query = """
    SELECT hcw.hierarchy_id, hcw.date, hcw.he, 
           hcw.data AS hedgecostwimbalance, rt_load.data AS rt_load
    FROM isone_vlr_tot_hedgecostwimbalance hcw
    JOIN rt_load_isone rt_load
    ON hcw.hierarchy_id = rt_load.hierarchy_id 
    AND hcw.date = rt_load.date 
    AND hcw.he = rt_load.he
    WHERE hcw.hierarchy_id BETWEEN 1 AND 8
"""
df = pd.read_sql(query, engine)  

df["date"] = pd.to_datetime(df["date"])
df["year"] = df["date"].dt.year
df["month"] = df["date"].dt.month
df['day'] = pd.to_datetime(df['date']).apply(lambda x: x.isoweekday() % 7 + 1)
df['day_type'] = df['day'].map(DAY_TYPE_MAPPING)
# df["hour_type"] = df["he"].apply(lambda x: "OnPeak" if 7 <= x <= 22 else "OffPeak")
df["hour_type"] = df["he"].apply(lambda x: "OnPeak" if 8 <= x <= 23 else "OffPeak")
def calculate_block_type(row):
    if row["day_type"] == "WeekDay" and row["hour_type"] == "OnPeak":
        return "5x16"
    elif row["day_type"] == "WeekEnd" and row["hour_type"] == "OnPeak":
        return "2x16"
    else:
        return "7x8"

df["block_type"] = df.apply(calculate_block_type, axis=1)

df["data"] = df.apply(lambda row: (row["hedgecostwimbalance"] / row["rt_load"]) 
                      if row["rt_load"] != 0 else 0, axis=1)  # Handles division by zero

df["data"] = df["data"].round(6)

df = df[["hierarchy_id", "date", "year", "month", "day", "day_type", "he", "hour_type", "block_type", "data"]]

conn = psycopg2.connect(**DB_PARAMS)
cursor = conn.cursor()

cursor.executemany("""
    INSERT INTO isone_vlr_tot_pricewimbalance 
    (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
    VALUES (%(hierarchy_id)s, %(date)s, %(year)s, %(month)s, %(day)s, %(day_type)s, %(he)s, %(hour_type)s, %(block_type)s, %(data)s)
    ON CONFLICT (hierarchy_id, date, he) 
    DO UPDATE SET data = EXCLUDED.data
""", df.to_dict(orient="records"))

conn.commit()
cursor.close()
conn.close()

print(" Data inserted into `isone_vlr_tot_pricewimbalance` successfully!")
