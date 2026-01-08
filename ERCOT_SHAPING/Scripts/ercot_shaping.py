import pandas as pd
from sqlalchemy import create_engine
import psycopg2

DB_PARAMS = {
    "dbname": "trueprice",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": "5432"
}

engine = create_engine(f"postgresql://{DB_PARAMS['user']}:{DB_PARAMS['password']}@{DB_PARAMS['host']}:{DB_PARAMS['port']}/{DB_PARAMS['dbname']}")


query = """
    SELECT hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data
    FROM ercot_shaping_da_lmps_avg;
"""
df = pd.read_sql(query, engine)

df = df.drop_duplicates(subset=["hierarchy_id", "date", "month", "he", "block_type"])


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

# Aggregate Numerator and Denominator
df_numerator = df.groupby(["hierarchy_id", "month", "he", "block_type"], as_index=False)["data"].mean().round(6)
df_denominator = df.groupby(["hierarchy_id", "month", "block_type"], as_index=False)["data"].mean().round(6)

# Merge Numerator and Denominator
df_final = pd.merge(df_numerator, df_denominator, on=["hierarchy_id", "month", "block_type"], how="left")
df_final["data"] = df_final["data_x"] / df_final["data_y"]  # numerator / denominator
df_final = df_final.drop(columns=["data_x", "data_y"])

df_dates = df.groupby(["hierarchy_id", "month", "he", "block_type"], as_index=False).first()
df_final = pd.merge(df_final, df_dates[["hierarchy_id", "month", "he", "block_type", "date", "year", "day", "day_type", "hour_type"]], on=["hierarchy_id", "month", "he", "block_type"], how="left")


df_final["data"] = df_final["data"].round(6)

expected_rows = 4 * 12 * 24 * 2  # (4 hierarchy_ids) * (12 months) * (24 hours) * (2 block types)
print(f"Final row count: {len(df_final)} (Expected: {expected_rows})")

conn = psycopg2.connect(**DB_PARAMS)
cursor = conn.cursor()

cursor.executemany("""
    INSERT INTO ercot_shaping 
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
        data = EXCLUDED.data;
""", df_final.to_dict(orient="records"))

conn.commit()
cursor.close()
conn.close()

print("Data inserted successfully into `ercot_shaping`!")
