import pandas as pd
import psycopg2

# ✅ Database connection parameters
DB_PARAMS = {
    "dbname": "trueprice",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": 5432
}

def insert_data_to_db(file_path, table_name):
    """
    Inserts data from the enriched ERCOT_DA_Clean_Shaping.csv file 
    into the ercot_shaping_da_lmps table with all required columns.
    """
    df = pd.read_csv(file_path)

    # ✅ Ensure columns are present
    required_cols = ["hierarchy_id", "date", "year", "month", "day", "day_type", 
                     "he", "hour_type", "block_type", "data"]
    for col in required_cols:
        if col not in df.columns:
            raise ValueError(f"❌ Missing column: {col} in {file_path}")

    # ✅ Open DB connection
    conn = psycopg2.connect(**DB_PARAMS)
    cursor = conn.cursor()

    # ✅ Insert rows
    for _, row in df.iterrows():
        cursor.execute(f"""
            INSERT INTO {table_name} 
            (hierarchy_id, date, year, month, day, day_type, he, hour_type, block_type, data)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (hierarchy_id, date, he)
            DO UPDATE SET 
                data = EXCLUDED.data,
                year = EXCLUDED.year,
                month = EXCLUDED.month,
                day = EXCLUDED.day,
                day_type = EXCLUDED.day_type,
                hour_type = EXCLUDED.hour_type,
                block_type = EXCLUDED.block_type;
        """, (row['hierarchy_id'], row['date'], row['year'], row['month'], row['day'], 
              row['day_type'], row['he'], row['hour_type'], row['block_type'], row['data']))

    # ✅ Commit changes
    conn.commit()
    cursor.close()
    conn.close()
    print(f"✅ Data from {file_path} inserted into {table_name}")

# ✅ Load the enriched shaping file
insert_data_to_db("ERCOT_DA_Clean_Shaping.csv", "ercot_shaping_da_lmps")
