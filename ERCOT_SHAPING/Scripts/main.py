#!/usr/bin/env python
import subprocess

scripts = [
    "da_lmps.py",
    "da_lmps_avg.py",
    "ercot_shaping.py",
]

for script in scripts:
    print(f"Running {script}...")
    subprocess.run(["/home/ubuntu/env_automation/bin/python", "ERCOT_SHAPING/Scripts/"+script], check=True)

print("All scripts executed successfully!")
