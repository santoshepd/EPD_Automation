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

# SQL query to fetch hedge cost without imbalance and cost of imbalance data
query = """
    SELECT hcwi.hierarchy_id, hcwi.date, hcwi.he, 
           hcwi.data AS hedgecostwoimbalance, ci.data AS costofimbalance
    FROM ercot_vlr_tot_hedgecostwoimbalance hcwi
    JOIN ercot_tot_costofimbalance ci
      ON hcwi.hierarchy_id = ci.hierarchy_id 
     AND hcwi.date = ci.date 
     AND hcwi.he = ci.he
    WHERE hcwi.hierarchy_id BETWEEN 1 AND 4
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

# Calculate the final data value by summing the two cost fields
df["data"] = (df["hedgecostwoimbalance"] + df["costofimbalance"]).round(6)

# Rearrange columns in the desired order
df = df[["hierarchy_id", "date", "year", "month", "day", "day_type", "he", "hour_type", "block_type", "data"]]

# Connect to PostgreSQL using psycopg2
conn = psycopg2.connect(dbname=db_name, user=db_user, password=db_password, host=db_host, port=db_port)
cursor = conn.cursor()

# Insert or update data into the target table
insert_query = """
    INSERT INTO ercot_vlr_tot_hedgecostwimbalance 
    (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
    VALUES (%(hierarchy_id)s, %(date)s, %(year)s, %(month)s, %(day)s, %(day_type)s, %(he)s, %(hour_type)s, %(block_type)s, %(data)s)
    ON CONFLICT (hierarchy_id, date, he) 
    DO UPDATE SET data = EXCLUDED.data
"""
cursor.executemany(insert_query, df.to_dict(orient="records"))

conn.commit()
cursor.close()
conn.close()

print("Data inserted into `ercot_vlr_tot_hedgecostwimbalance` successfully!")
