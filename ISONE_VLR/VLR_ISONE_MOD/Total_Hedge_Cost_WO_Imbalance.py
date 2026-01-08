import pandas as pd
from sqlalchemy import create_engine
import psycopg2
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv(override=True)

# PostgreSQL engine using .env credentials
DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}

engine_str = f"postgresql://{DB_PARAMS['user']}:{DB_PARAMS['password']}@{DB_PARAMS['host']}:{DB_PARAMS['port']}/{DB_PARAMS['dbname']}"
engine = create_engine(engine_str)

DAY_TYPE_MAPPING = {
    1: "WeekEnd",  # Sunday
    2: "WeekDay",  # Monday
    3: "WeekDay",
    4: "WeekDay",
    5: "WeekDay",
    6: "WeekDay",
    7: "WeekEnd"   # Saturday
}

# Fetch DA LMPs and Load Data
query = """
    SELECT da_lmps.hierarchy_id, da_lmps.date, da_lmps.he, 
           da_lmps.data AS da_lmps, da_load.data AS da_load
    FROM da_lmps_isone da_lmps
    JOIN da_load_isone da_load 
    ON da_lmps.hierarchy_id = da_load.hierarchy_id 
    AND da_lmps.date = da_load.date 
    AND da_lmps.he = da_load.he
    WHERE da_lmps.hierarchy_id BETWEEN 1 AND 8
"""
df = pd.read_sql(query, engine)  

# Add metadata
df["date"] = pd.to_datetime(df["date"])
df["year"] = df["date"].dt.year
df["month"] = df["date"].dt.month
df['day'] = df["date"].apply(lambda x: x.isoweekday() % 7 + 1)
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
df["data"] = (df["da_lmps"] * df["da_load"]).round(6)
df = df[["hierarchy_id", "date", "year", "month", "day", "day_type", "he", "hour_type", "block_type", "data"]]

# Insert into database
conn = psycopg2.connect(**DB_PARAMS)
cursor = conn.cursor()

cursor.executemany("""
    INSERT INTO isone_vlr_tot_hedgecostwoimbalance 
    (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
    VALUES (%(hierarchy_id)s, %(date)s, %(year)s, %(month)s, %(day)s, %(day_type)s, %(he)s, %(hour_type)s, %(block_type)s, %(data)s)
    ON CONFLICT (hierarchy_id, date, he) 
    DO UPDATE SET data = EXCLUDED.data
""", df.to_dict(orient="records"))

conn.commit()
cursor.close()
conn.close()

print("✅ Data inserted into `isone_vlr_tot_hedgecostwoimbalance` successfully!")
