import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine
import psycopg2
from io import StringIO

# Load DB credentials from .env
load_dotenv(override=True)
DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}

# DB engine
engine_str = f"postgresql://{DB_PARAMS['user']}:{DB_PARAMS['password']}@{DB_PARAMS['host']}:{DB_PARAMS['port']}/{DB_PARAMS['dbname']}"
engine = create_engine(engine_str)

DAY_TYPE_MAPPING = {
    1: "WeekEnd",  # Sunday
    2: "WeekDay",  # Monday
    3: "WeekDay",  # Tuesday
    4: "WeekDay",  # Wednesday
    5: "WeekDay",  # Thursday
    6: "WeekDay",  # Friday
    7: "WeekEnd"   # Saturday
}

# Fetch Load Variance and RT_LMPS Data
query = """
    SELECT lv.hierarchy_id, lv.date, lv.he, 
           lv.data AS load_variance, rt_lmps.data AS rt_lmps
    FROM load_variance_isone lv
    JOIN rt_lmps_isone rt_lmps 
    ON lv.hierarchy_id = rt_lmps.hierarchy_id 
    AND lv.date = rt_lmps.date 
    AND lv.he = rt_lmps.he
    WHERE lv.hierarchy_id BETWEEN 1 AND 8
"""
df = pd.read_sql(query, engine)

# Metadata enrichment
df["date"] = pd.to_datetime(df["date"])
df["year"] = df["date"].dt.year
df["month"] = df["date"].dt.month
df['day'] = df['date'].apply(lambda x: x.isoweekday() % 7 + 1)
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

# Compute cost of imbalance
df["data"] = (df["load_variance"] * df["rt_lmps"]).round(6)

# Reorder columns
df = df[["hierarchy_id", "date", "year", "month", "day", "day_type", "he", "hour_type", "block_type", "data"]]

# Insert to DB via copy_from
def insert_data_to_db(df, table_name):
    if df.empty:
        print(f"No new data to insert for {table_name}.")
        return

    try:
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()
        output = StringIO()
        df.to_csv(output, sep='\t', header=False, index=False)
        output.seek(0)
        cursor.copy_from(output, table_name, sep='\t',
                         columns=('hierarchy_id', 'date', 'year', 'month', 'day',
                                  'day_type', 'he', 'hour_type', 'block_type', 'data'))
        conn.commit()
        cursor.close()
        conn.close()
        print(f"✅ Data inserted into `{table_name}` successfully!")
    except Exception as e:
        print(f"❌ Error inserting data into {table_name}: {e}")

insert_data_to_db(df, "isone_tot_costofimbalance")
