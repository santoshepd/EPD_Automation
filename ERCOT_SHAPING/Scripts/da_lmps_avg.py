from sqlalchemy import create_engine
import pandas as pd

DB_URI = "postgresql://postgres:postgres@localhost:5432/trueprice"
engine = create_engine(DB_URI)

# Load DA_LMPS data
query = """
    SELECT hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data
    FROM ercot_shaping_da_lmps
"""
df = pd.read_sql(query, engine)

# Compute AVERAGEIFS logic
df_avg = df.groupby(["hierarchy_id", "month", "he", "block_type"]).agg(
    avg_data=("data", "mean")
).reset_index()

# Merge with additional details
df_avg = df_avg.merge(df[['hierarchy_id', 'month', 'he', 'block_type', 'date', 'year', 'day', 'day_type', 'hour_type']],
                      on=["hierarchy_id", "month", "he", "block_type"],
                      how="left").drop_duplicates()

df_avg.rename(columns={"avg_data": "data"}, inplace=True)

# Insert data into PostgreSQL
conn = engine.raw_connection()
cursor = conn.cursor()

for row in df_avg.itertuples(index=False):
    cursor.execute("""
        INSERT INTO ercot_shaping_da_lmps_avg (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (hierarchy_id, date, he) 
        DO UPDATE SET data = EXCLUDED.data;
    """, (row.hierarchy_id, row.date, row.year, row.month, row.day, row.day_type, row.he, row.hour_type, row.block_type, row.data))

conn.commit()
cursor.close()
conn.close()

print("Data inserted/updated successfully!")
