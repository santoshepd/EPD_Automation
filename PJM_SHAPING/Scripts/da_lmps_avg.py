from sqlalchemy import create_engine
import pandas as pd

# DB_URI = "postgresql://postgres:postgres@localhost:5432/trueprice"
DB_URI = f"postgresql://{os.getenv('DB_USER', 'postgres')}:{os.getenv('DB_PASSWORD', 'postgres')}@{os.getenv('DB_HOST', 'localhost')}:{os.getenv('DB_PORT', '5432')}/{os.getenv('DB_NAME', 'epdauto')}"
engine = create_engine(DB_URI)

# Load DA_LMPS data
query = """
    SELECT hierarchy_id, date, he, data
      FROM da_lmps_pjm_sh; 
"""
# FROM da_lmps_pjm_sh; # added this line
df = pd.read_sql(query, engine)


df['datetime'] = pd.to_datetime(df['date'])
df['date'] = df['datetime'].dt.date
df['year'] = df['datetime'].dt.year
df['month'] = df['datetime'].dt.month
df['day'] = pd.to_datetime(df['date']).apply(lambda x: x.isoweekday() % 7 + 1)

# Day type mapping
DAY_TYPE_MAPPING = {1: 'WeekEnd', 2: 'WeekDay', 3: 'WeekDay', 4: 'WeekDay', 
                    5: 'WeekDay', 6: 'WeekDay', 7: 'WeekEnd'}
df['day_type'] = df['day'].map(DAY_TYPE_MAPPING)

# Hour type
df['hour_type'] = df['he'].apply(lambda x: "OnPeak" if 7 <= x <= 22 else "OffPeak")
    
# Block type
def calculate_block_type(row):
                if row["day_type"] == "WeekDay" and row["hour_type"] == "OnPeak":
                    return "5x16"
                elif row["day_type"] == "WeekEnd" and row["hour_type"] == "OnPeak":
                    return "2x16"
                else:
                    return "7x8"
            
df['block_type'] = df.apply(calculate_block_type, axis=1)

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
        INSERT INTO da_lmps_avg_pjm (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (hierarchy_id, date, he) 
        DO UPDATE SET data = EXCLUDED.data;
    """, (row.hierarchy_id, row.date, row.year, row.month, row.day, row.day_type, row.he, row.hour_type, row.block_type, row.data))

conn.commit()
cursor.close()
conn.close()

print("Data inserted/updated successfully!")
