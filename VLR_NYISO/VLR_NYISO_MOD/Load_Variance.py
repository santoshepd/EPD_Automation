import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine
import psycopg2

# Load .env variables
load_dotenv(override=True)

DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}

# SQLAlchemy engine for reading
engine_str = f"postgresql://{DB_PARAMS['user']}:{DB_PARAMS['password']}@{DB_PARAMS['host']}:{DB_PARAMS['port']}/{DB_PARAMS['dbname']}"
engine = create_engine(engine_str)

# Step 1: Join RT + DA Load
query = """
    SELECT rt.hierarchy_id, rt.date, rt.he, rt.data AS rt_data, da.data AS da_data
    FROM nyiso_vlr_rt_load rt
    JOIN nyiso_vlr_da_load da 
    ON rt.hierarchy_id = da.hierarchy_id 
    AND rt.date = da.date 
    AND rt.he = da.he
    WHERE rt.hierarchy_id BETWEEN 1 AND 11
"""
df = pd.read_sql(query, engine)

# Step 2: Add metadata
df["date"] = pd.to_datetime(df["date"])
df["year"] = df["date"].dt.year
df["month"] = df["date"].dt.month
df["day"] = df["date"].apply(lambda x: x.isoweekday() % 7 + 1)
df["day_type"] = df["date"].dt.dayofweek.apply(lambda x: "WeekEnd" if x in [5, 6] else "WeekDay")
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

# Step 3: Calculate variance
df["data"] = (df["rt_data"] - df["da_data"]).round(6)

# Step 4: Final columns to insert
df = df[[
    "hierarchy_id", "date", "year", "month", "day",
    "day_type", "he", "hour_type", "block_type", "data"
]]

# Step 5: Insert into nyiso_vlr_load_variance
try:
    conn = psycopg2.connect(**DB_PARAMS)
    cursor = conn.cursor()

    insert_query = """
        INSERT INTO nyiso_vlr_load_variance 
        (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
        VALUES (%(hierarchy_id)s, %(date)s, %(year)s, %(month)s, %(day)s, %(day_type)s, %(he)s, %(hour_type)s, %(block_type)s, %(data)s)
        ON CONFLICT (hierarchy_id, date, he) 
        DO UPDATE SET data = EXCLUDED.data
    """

    cursor.executemany(insert_query, df.to_dict(orient="records"))
    conn.commit()
    cursor.close()
    conn.close()
    print("✅ Data inserted into `nyiso_vlr_load_variance` successfully!")

except Exception as e:
    print(f"❌ Error inserting data into `nyiso_vlr_load_variance`: {e}")
