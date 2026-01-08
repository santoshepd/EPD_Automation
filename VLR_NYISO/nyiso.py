# import pandas as pd
# import psycopg2
# from psycopg2.extras import execute_values
# import os

# # ✅ Database credentials
# DB_NAME = "trueprice"
# DB_USER = "postgres"
# DB_PASSWORD = "postgres"
# DB_HOST = "localhost"
# DB_PORT = "5432"

# # ✅ Path to your EC2 directory
# base_path = "/home/ubuntu/workspace/hp/repos/db_populate_V2/TLE-Automation/VLR_NYISO"

# # ✅ File-to-table mapping
# files_tables = {
#     "DA_LMPS_NYISOS_FINAL.xlsx": "nyiso_vlr_da_lmps",
#     "RT_LMPS_NYISOS_FINAL.xlsx": "nyiso_vlr_rt_lmps",
#     "DA_LOAD_NYISOS_FINAL.xlsx": "nyiso_vlr_da_load",
#     "RT_LOAD_NYISOS_FINAL.xlsx": "nyiso_vlr_rt_load"
# }

# def insert_data(file_path, table_name, cursor):
#     print(f"📥 Processing {file_path} → {table_name}")

#     # ✅ Read Excel file directly
#     df = pd.read_excel(file_path)

#     # ✅ Ensure column names are as expected
#     expected_cols = ['hierarchy_id', 'date', 'he', 'data']
#     if not all(col in df.columns for col in expected_cols):
#         raise ValueError(f"❌ File {file_path} does not have the expected columns: {expected_cols}")

#     # ✅ Convert DataFrame rows into tuples
#     data_tuples = [tuple(row) for row in df.to_numpy()]

#     # ✅ Conflict-safe insert query
#     insert_query = f"""
#         INSERT INTO {table_name} (hierarchy_id, date, he, data)
#         VALUES %s
#         ON CONFLICT (hierarchy_id, date, he) DO NOTHING;
#     """

#     try:
#         execute_values(cursor, insert_query, data_tuples)
#         print(f"✅ Inserted {len(df)} rows into {table_name} (duplicates skipped)")
#     except Exception as e:
#         print(f"❌ Error inserting into {table_name}: {e}")

# def main():
#     conn = None
#     try:
#         conn = psycopg2.connect(
#             dbname=DB_NAME,
#             user=DB_USER,
#             password=DB_PASSWORD,
#             host=DB_HOST,
#             port=DB_PORT
#         )
#         cursor = conn.cursor()

#         for file_name, table_name in files_tables.items():
#             file_path = os.path.join(base_path, file_name)
#             insert_data(file_path, table_name, cursor)

#         conn.commit()
#         print("🎉 All NYISO data inserted successfully!")

#     except Exception as e:
#         print(f"🚨 Database connection failed: {e}")

#     finally:
#         if conn:
#             cursor.close()
#             conn.close()

# if __name__ == "__main__":
#     main()

import pandas as pd
import psycopg2

# --- DB Connection Parameters ---
DB_PARAMS = {
    "dbname": "trueprice",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": 5432
}

# --- Files and their corresponding tables ---
files_tables = {
    "NYISO_DA_LMP.xlsx": "nyiso_vlr_da_lmps",
    "NYISO_RT_LMP.xlsx": "nyiso_vlr_rt_lmps",
    "NYISO_DA_LOA.xlsx": "nyiso_vlr_da_load",
    "NYISO_RT_LOA.xlsx": "nyiso_vlr_rt_load"
}

def insert_data_to_db(file_path, table_name):
    # ✅ Read Excel file (not CSV)
    df = pd.read_excel(file_path)
    
    # ✅ Ensure required columns exist
    expected_cols = {'hierarchy_id', 'date', 'he', 'data'}
    if not expected_cols.issubset(df.columns):
        raise ValueError(f"❌ {file_path} is missing required columns: {expected_cols - set(df.columns)}")

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
    print(f"✅ Data from {file_path} inserted into {table_name}")

# --- Loop through all files & tables ---
for file, table in files_tables.items():
    insert_data_to_db(file, table)
