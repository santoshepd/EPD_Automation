#!/usr/bin/env python
import subprocess

scripts = [
    "DA_RT_LMPS.py",
    "DA_RT_LOAD.py",
    "Price_Variance.py",
    "Load_Variance.py",
    "Total_Hedge_Cost_WO_Imbalance.py",
    "Total_Cost_of_Imbalance.py",
    "Total_Hedge_Cost_W_Imbalance.py",
    "Total_Price_W_Imbalance.py",
    "Utilized_Cost.py",
    "Hourly_VLR.py",
    "ERCOT_VLR.py",
]

for script in scripts:
    print(f"Running {script}...")
    subprocess.run(["/home/ubuntu/workspace/hp/envs/TLE/bin/python3",  f"./{script}"], check=True)

print("All scripts executed successfully!")
