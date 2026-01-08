#!/usr/bin/env python
import subprocess

scripts = [
    "DA_RT_LMPS.py",                          # Real-time & Day-ahead LMPs
    "DA_RT_LOAD.py",                          # Real-time & Day-ahead Loads
    "Price_Variance.py",                      # VLR Price Variance
    "Price_Var_Percentage.py",           # VLR Price Variance %
    "Load_Variance.py",                       # Load Variance
    "Load_Var_Percentage.py",            # Load Variance %
    "Total_Hedge_Cost_WO_Imbalance.py",       # Hedge Cost without Imbalance
    "Total_Cost_of_Imbalance.py",             # Cost of Imbalance
    "Total_Hedge_Cost_W_Imbalance.py",        # Hedge Cost with Imbalance
    "Total_Price_W_Imbalance.py",             # Total Price with Imbalance
    "Utilized_Cost.py",                       # Utilized Cost = TPwI - DALMP
    "Hourly_VLR.py",                         # Hourly Cost %
    "PJM_VLR.py",                 # Final VLR
]

for script in scripts:
    print(f"🚀 Running {script}...")
    subprocess.run(["/home/ubuntu/workspace/hp/envs/TLE/bin/python3",  f"./{script}"], check=True)

print("✅ All PJM scripts executed successfully!")
