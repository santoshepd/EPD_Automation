import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine
import psycopg2

# Load environment variables from .env
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

# Step 1: Fetch from miso_vlr_hourly_cost
query = """
    SELECT hierarchy_id, date, he, data AS hourly_vlr_cost
    FROM miso_vlr_hourly_cost
    WHERE hierarchy_id BETWEEN 1 AND 19
"""
df = pd.read_sql(query, engine)

# Step 2: Date breakdown and classification
df["date"] = pd.to_datetime(df["date"])
df["year"] = df["date"].dt.year
df["month"] = df["date"].dt.month
df["day"] = df["date"].apply(lambda x: x.isoweekday() % 7 + 1)
df["day_type"] = df["date"].dt.dayofweek.apply(lambda x: "WeekEnd" if x in [5, 6] else "WeekDay")
# df["hour_type"] = df["he"].apply(lambda x: "OnPeak" if 7 <= x <= 22 else "OffPeak")
df["hour_type"] = df["he"].apply(lambda x: "OnPeak" if 8 <= x <= 23 else "OffPeak")

# Step 3: Calculate block type
def calculate_block_type(row):
    if row["day_type"] == "WeekDay" and row["hour_type"] == "OnPeak":
        return "5x16"
    elif row["day_type"] == "WeekEnd" and row["hour_type"] == "OnPeak":
        return "2x16"
    else:
        return "7x8"

df["block_type"] = df.apply(calculate_block_type, axis=1)

# Step 4: Create grouping string
df["concat_string"] = df["month"].astype(str) + "_" + df["he"].astype(str) + "_" + df["block_type"]

# Step 5: Mode function
def mode_function(x):
    return x.mode()[0] if not x.mode().empty else None

# Step 6: Group and aggregate
agg_df = df.groupby(["hierarchy_id", "concat_string"]).agg({
    "date": "first",
    "year": "first",
    "month": "first",
    "day": "first",
    "day_type": mode_function,
    "hourly_vlr_cost": "mean",
    "he": "mean",
    "hour_type": mode_function,
    "block_type": mode_function
}).reset_index()

# Final formatting
agg_df = agg_df.sort_values(by=['hierarchy_id', 'month', 'he'])
agg_df.rename(columns={"hourly_vlr_cost": "data"}, inplace=True)
agg_df["data"] = agg_df["data"].round(6)

agg_df = agg_df[[
    "hierarchy_id", "date", "year", "month", "day",
    "day_type", "he", "hour_type", "block_type", "data"
]]

# Step 7: Insert into miso_vlr
try:
    conn = psycopg2.connect(**DB_PARAMS)
    cursor = conn.cursor()

    insert_query = """
        INSERT INTO miso_vlr 
        (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
        VALUES (%(hierarchy_id)s, %(date)s, %(year)s, %(month)s, %(day)s, %(day_type)s, %(he)s, %(hour_type)s, %(block_type)s, %(data)s)
        ON CONFLICT (hierarchy_id, date, he, block_type) 
        DO UPDATE SET 
            year = EXCLUDED.year,
            month = EXCLUDED.month,
            day = EXCLUDED.day,
            day_type = EXCLUDED.day_type,
            hour_type = EXCLUDED.hour_type,
            block_type = EXCLUDED.block_type,
            data = EXCLUDED.data
    """

    cursor.executemany(insert_query, agg_df.to_dict(orient="records"))
    conn.commit()
    cursor.close()
    conn.close()

    print("✅ Data inserted into `miso_vlr` successfully!")

except Exception as e:
    print(f"❌ Error inserting into `miso_vlr`: {e}")
