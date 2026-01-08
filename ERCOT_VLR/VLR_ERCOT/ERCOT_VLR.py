#!/usr/bin/env python
import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine
import psycopg2

# Load environment variables from the .env file
load_dotenv()

# Retrieve DB credentials from environment variables
db_name = os.getenv("DB_NAME")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")
db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")

# Create SQLAlchemy engine using the credentials
engine = create_engine(f"postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}")

# SQL query to fetch data from ercot_vlr_hourly_cost
query = """
    SELECT hierarchy_id, date, he, data AS hourly_vlr_cost
    FROM ercot_vlr_hourly_cost
    WHERE hierarchy_id BETWEEN 1 AND 4
"""
df = pd.read_sql(query, engine)

# Process the DataFrame
df["date"] = pd.to_datetime(df["date"])
df["year"] = df["date"].dt.year
df["month"] = df["date"].dt.month
df["day"] = df["date"].dt.day

df["day_type"] = df["date"].dt.dayofweek.apply(lambda x: "WeekEnd" if x in [5, 6] else "WeekDay")
df["hour_type"] = df["he"].apply(lambda x: "OnPeak" if 7 <= x <= 22 else "OffPeak")

def calculate_block_type(row):
    if row["day_type"] == "WeekDay" and row["hour_type"] == "OnPeak":
        return "5x16"
    elif row["day_type"] == "WeekEnd" and row["hour_type"] == "OnPeak":
        return "2x16"
    else:
        return "7x8"

df["block_type"] = df.apply(calculate_block_type, axis=1)

# Create a concatenated string to group by month, hour, and block type
df["concat_string"] = df["month"].astype(str) + "_" + df["he"].astype(str) + "_" + df["block_type"]

# Define a helper function to calculate the mode
def mode_function(x):
    return x.mode()[0] if not x.mode().empty else None

# Group by hierarchy_id and the concatenated string, aggregating relevant fields
agg_df = df.groupby(["hierarchy_id", "concat_string"]).agg(
    {
        "date": "first",  
        "year": "first",
        "month": "first",
        "day": "first", 
        "day_type": mode_function,
        "hourly_vlr_cost": "mean",  # Mean for VLR cost
        "he": "mean",               # Mean for Hour
        "hour_type": mode_function,  # Mode for HourType
        "block_type": mode_function  # Mode for BlockType
    }
).reset_index()

# Sort and clean up the aggregated DataFrame
agg_df = agg_df.sort_values(by=['hierarchy_id', 'month', 'he'])
agg_df.rename(columns={"hourly_vlr_cost": "data"}, inplace=True)
agg_df["data"] = agg_df["data"].round(6)
agg_df = agg_df[["hierarchy_id", "date", "year", "month", "day", "day_type", "he", "hour_type", "block_type", "data"]]

# Connect to PostgreSQL using psycopg2
conn = psycopg2.connect(dbname=db_name, user=db_user, password=db_password, host=db_host, port=db_port)
cursor = conn.cursor()

# Insert or update the aggregated data into ercot_vlr table
cursor.executemany("""
    INSERT INTO ercot_vlr 
    (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
    VALUES (%(hierarchy_id)s, %(date)s, %(year)s, %(month)s, %(day)s, %(day_type)s, %(he)s, %(hour_type)s, %(block_type)s, %(data)s)
    ON CONFLICT (hierarchy_id, date, he) 
    DO UPDATE SET 
        year = EXCLUDED.year,
        month = EXCLUDED.month,
        day = EXCLUDED.day,
        day_type = EXCLUDED.day_type,
        hour_type = EXCLUDED.hour_type,
        block_type = EXCLUDED.block_type,
        data = EXCLUDED.data
""", agg_df.to_dict(orient="records"))

conn.commit()
cursor.close()
conn.close()

print("Data inserted into ercot_vlr successfully!")
