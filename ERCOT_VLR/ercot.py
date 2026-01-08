import pandas as pd
import psycopg2

DB_PARAMS = {
    "dbname": "trueprice",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": 5432
}

def insert_data_to_db(file_path, table_name):
    df = pd.read_csv(file_path)
    conn = psycopg2.connect(**DB_PARAMS)
    cursor = conn.cursor()

    for _, row in df.iterrows():
        cursor.execute(f"""
            INSERT INTO {table_name} (hierarchy_id, date, he, data)
            VALUES (%s, %s, %s, %s)
            ON CONFLICT (hierarchy_id, date, he)
            DO UPDATE SET data = EXCLUDED.data;
        """, (row['hierarchy_id'], row['date'], row['he'], row['data']))

    conn.commit()
    cursor.close()
    conn.close()
    print(f"Data from {file_path} inserted into {table_name}")

# Load all four files
insert_data_to_db("ERCOT_DA_Clean.csv", "da_lmps_ercot")
insert_data_to_db("ERCOT_RT_Clean.csv", "rt_lmps_ercot")
insert_data_to_db("ERCOT_DA_LOAD_Clean.csv", "da_load_ercot")
insert_data_to_db("ERCOT_RT_LOAD_Clean.csv", "rt_load_ercot")
