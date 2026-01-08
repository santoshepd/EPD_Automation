import pandas as pd
import psycopg2
from psycopg2.extras import execute_values

# 📌 DB connection details
DB_PARAMS = {
    "dbname": "trueprice",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": 5432
}

# 📁 File to Table mapping
file_table_map = {
    "ISONE_RT_LMPS_FINAL.xlsx": "rt_lmps_isone",
    "ISONE_DA_LOAD_FINAL.xlsx": "da_load_isone",
    "ISONE_DA_LMPS_FINAL.xlsx": "da_lmps_isone",
    "ISONE_RT_LOAD_FINAL.xlsx": "rt_load_isone"
}

# 📂 Base directory where the files are located
base_dir = "/home/ubuntu/workspace/hp/repos/db_populate_V2/TLE-Automation/ISONE_VLR"

# 🔄 Insert function
def insert_data_to_db(df, table_name):
    if df.empty:
        print(f"⚠️ No new data to insert for {table_name}.")
        return

    try:
        # ✅ Drop duplicates on key fields
        df = df.drop_duplicates(subset=['hierarchy_id', 'date', 'he'], keep='last')
        df = df.astype(object)

        # ✅ Connect to DB
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()

        columns = ['hierarchy_id', 'date', 'year', 'month', 'day',
                   'day_type', 'he', 'hour_type', 'block_type', 'data']
        values = df[columns].values.tolist()

        insert_query = f"""
        INSERT INTO {table_name} ({', '.join(columns)})
        VALUES %s
        ON CONFLICT (hierarchy_id, date, he)
        DO UPDATE SET data = EXCLUDED.data
        """

        # ✅ Execute bulk insert
        execute_values(cursor, insert_query, values)
        conn.commit()

        cursor.close()
        conn.close()

        print(f"✅ Data inserted successfully into {table_name}!")

    except Exception as e:
        print(f"❌ Error inserting data into {table_name}: {e}")

# 🚀 Loop through all files and insert
for file_name, table_name in file_table_map.items():
    file_path = f"{base_dir}/{file_name}"
    print(f"📥 Reading {file_path} for table {table_name}...")

    try:
        df = pd.read_excel(file_path)
        insert_data_to_db(df, table_name)
    except Exception as e:
        print(f"❌ Error processing {file_name}: {e}")
