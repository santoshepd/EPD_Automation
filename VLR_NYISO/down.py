import pandas as pd
import psycopg2

# ✅ DB credentials
DB_NAME = "trueprice"
DB_USER = "postgres"
DB_PASSWORD = "postgres"
DB_HOST = "localhost"
DB_PORT = "5432"

# ✅ Tables to export
tables = {
    "nyiso_vlr_da_load": "DA_LOAD_NYISOS.xlsx",
    "nyiso_vlr_rt_load": "RT_LOAD_NYISOS.xlsx",
    "nyiso_vlr_da_lmps": "DA_LMPS_NYISOS.xlsx",
    "nyiso_vlr_rt_lmps": "RT_LMPS_NYISOS.xlsx"
}

def export_table_to_excel():
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT
        )

        for table, filename in tables.items():
            print(f"📥 Exporting {table} ...")
            query = f"SELECT * FROM {table};"
            df = pd.read_sql(query, conn)
            df.to_excel(filename, index=False)
            print(f"✅ {table} exported to {filename}")

        conn.close()
        print("🎉 All tables exported successfully!")

    except Exception as e:
        print(f"❌ Error: {e}")

if __name__ == "__main__":
    export_table_to_excel()
