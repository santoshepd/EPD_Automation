#!/usr/bin/env python
import subprocess

scripts = [
    "da_lmps.py",
    "da_lmps_avg.py",
    "pjm_shaping.py",
]

for script in scripts:
    print(f"Running {script}...")
    subprocess.run(["/home/ubuntu/workspace/hp/envs/TLE/bin/python3",  f"./{script}"], check=True)

print("All scripts executed successfully!")
