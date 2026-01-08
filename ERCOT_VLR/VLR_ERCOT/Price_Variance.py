#!/usr/bin/env python
import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine
import psycopg2

# Load environment variables from .env
load_dotenv()

# Retrieve DB credentials from environment variables
db_name = os.getenv("DB_NAME")
db_user = os.getenv("DB_USER")
db_password = os.getenv("DB_PASSWORD")
db_host = os.getenv("DB_HOST")
db_port = os.getenv("DB_PORT")

# Create SQLAlchemy engine using the credentials
engine = create_engine(f"postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}")

# Fetch RT_LMPS and DA_LMPS Data
query = """
    SELECT rt.hierarchy_id, rt.date, rt.he, rt.data AS rt_data, da.data AS da_data
    FROM rt_lmps_ercot rt
    JOIN da_lmps_ercot da 
      ON rt.hierarchy_id = da.hierarchy_id 
     AND rt.date = da.date 
     AND rt.he = da.he
    WHERE rt.hierarchy_id BETWEEN 1 AND 8
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

df["data"] = df.apply(
    lambda row: (row["rt_data"] - row["da_data"])
    if row["hierarchy_id"] <= 4
    else (row["rt_data"] - row["da_data"]) / (row["da_data"] if row["da_data"] != 0 else 1),
    axis=1
).round(6)

df = df[["hierarchy_id", "date", "year", "month", "day", "day_type", "he", "hour_type", "block_type", "data"]]

# Connect to PostgreSQL using psycopg2 and insert the data
conn = psycopg2.connect(dbname=db_name, user=db_user, password=db_password, host=db_host, port=db_port)
cursor = conn.cursor()

cursor.executemany("""
    INSERT INTO price_variance_ercot 
      (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
    VALUES (%(hierarchy_id)s, %(date)s, %(year)s, %(month)s, %(day)s, %(day_type)s, %(he)s, %(hour_type)s, %(block_type)s, %(data)s)
    ON CONFLICT (hierarchy_id, date, he) 
    DO UPDATE SET data = EXCLUDED.data
""", df.to_dict(orient="records"))

conn.commit()
cursor.close()
conn.close()

print("Data inserted into `price_variance_ercot` successfully!")
