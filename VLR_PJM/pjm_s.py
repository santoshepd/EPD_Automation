import pandas as pd
import psycopg2
from psycopg2.extras import execute_values

# Database credentials
DB_NAME = "trueprice"
DB_USER = "postgres"
DB_PASSWORD = "postgres"
DB_HOST = "localhost"
DB_PORT = "5432"

# ✅ Correct file paths for EC2
files_tables = {
    "/home/ubuntu/workspace/hp/repos/db_populate_V2/TLE-Automation/VLR_PJM/DA_LMPS_PJM_FORMATTED.xlsx": "pjm_vlr_da_lmps",
    "/home/ubuntu/workspace/hp/repos/db_populate_V2/TLE-Automation/VLR_PJM/RT_LMPS_PJM_FORMATTED.xlsx": "pjm_vlr_rt_lmps",
    "/home/ubuntu/workspace/hp/repos/db_populate_V2/TLE-Automation/VLR_PJM/PJM_DA_LOAD_FORMATTED.xlsx": "pjm_vlr_da_load",
    "/home/ubuntu/workspace/hp/repos/db_populate_V2/TLE-Automation/VLR_PJM/PJM_RT_LOAD_FORMATTED.xlsx": "pjm_vlr_rt_load"
}

def clean_date(df):
    """Ensure date is YYYY-MM-DD"""
    df['date'] = pd.to_datetime(df['date']).dt.strftime('%Y-%m-%d')
    return df

def insert_data(file_path, table_name, cursor):
    print(f"Processing {file_path} → {table_name}")
    df = pd.read_excel(file_path)
    df = clean_date(df)

    # Prepare data tuples for psycopg2
    data_tuples = [tuple(x) for x in df.to_numpy()]

    insert_query = f"""
        INSERT INTO {table_name} (hierarchy_id, date, he, data)
        VALUES %s
    """

    try:
        execute_values(cursor, insert_query, data_tuples)
        print(f"✅ Inserted {len(df)} rows into {table_name}")
    except Exception as e:
        print(f"❌ Error inserting into {table_name}: {e}")

def main():
    conn = None
    try:
        # Connect to DB
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT
        )
        cursor = conn.cursor()

        for file_path, table_name in files_tables.items():
            insert_data(file_path, table_name, cursor)

        conn.commit()
        print("🎉 All data inserted successfully!")

    except Exception as e:
        print(f"Database connection failed: {e}")

    finally:
        if conn:
            cursor.close()
            conn.close()

if __name__ == "__main__":
    main()
