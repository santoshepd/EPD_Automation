import pandas as pd
import psycopg2
from sqlalchemy import create_engine

# ✅ DB connection params
DB_PARAMS = {
    "dbname": "trueprice",
    "user": "postgres",
    "password": "postgres",
    "host": "localhost",
    "port": "5432"
}

# ✅ Output path
output_file = "/home/ubuntu/workspace/hp/repos/db_populate_V2/TLE-Automation/PJM_SHAPING/PJM_DA_LMP_Export.xlsx"

# ✅ SQL query to fetch everything from pjm_vlr_da_lmps
query = "SELECT * FROM pjm_vlr_da_lmps;"

# ✅ Create engine & load data
engine = create_engine(f"postgresql+psycopg2://{DB_PARAMS['user']}:{DB_PARAMS['password']}@{DB_PARAMS['host']}:{DB_PARAMS['port']}/{DB_PARAMS['dbname']}")
df = pd.read_sql(query, engine)

if df.empty:
    print("⚠️ No data found in pjm_vlr_da_lmps table.")
else:
    # ✅ Save DataFrame to Excel
    df.to_excel(output_file, index=False)
    print(f"✅ Data from `pjm_vlr_da_lmps` exported successfully to: {output_file}")
