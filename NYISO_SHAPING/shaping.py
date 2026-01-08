import pandas as pd
import psycopg2

# ✅ DB connection params
DB_PARAMS = {
    "dbname": "trueprice",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": 5432
}

# ✅ Path to Excel file
file_path = "/home/ubuntu/workspace/hp/repos/db_populate_V2/TLE-Automation/NYISO_SHAPING/NYISO_DA_LMP_Processed.xlsx"

# ✅ Table to insert into
table_name = "da_lmps_nyiso_sh"   # 👈 change if you want to insert into nyiso_shaping instead

# ✅ Read Excel file
df = pd.read_excel(file_path)

# ✅ Convert date column to datetime & ensure YYYY-MM-DD format
df["date"] = pd.to_datetime(df["date"]).dt.date

# ✅ Open DB connection
conn = psycopg2.connect(**DB_PARAMS)
cursor = conn.cursor()

# ✅ Insert data
insert_query = f"""
    INSERT INTO {table_name} 
    (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
    VALUES (%(hierarchy_id)s, %(date)s, %(year)s, %(month)s, %(day)s, %(day_type)s, %(he)s, %(hour_type)s, %(block_type)s, %(data)s)
    ON CONFLICT (hierarchy_id, date, he) 
    DO UPDATE SET data = EXCLUDED.data;
"""

cursor.executemany(insert_query, df.to_dict(orient="records"))

# ✅ Commit & Close
conn.commit()
cursor.close()
conn.close()

print(f"✅ Data from {file_path} inserted into `{table_name}` successfully!")
