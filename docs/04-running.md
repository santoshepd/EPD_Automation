# Running the Application

This guide explains how to run each component of the EPD Automation system.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Running VLR Calculations](#running-vlr-calculations)
3. [Running Shaping Calculations](#running-shaping-calculations)
4. [Running ICE Automation](#running-ice-automation)
5. [Running Streamlit Dashboard](#running-streamlit-dashboard)
6. [Running Complete Pipeline](#running-complete-pipeline)
7. [Scheduling & Automation](#scheduling--automation)

## Prerequisites

Before running any scripts:

1. **Environment Setup**: Complete the [Setup Guide](02-setup.md)
2. **Database**: Ensure PostgreSQL is running and schemas are created
3. **Environment Variables**: Verify `.env` file is configured
4. **API Access**: Ensure you have valid API credentials (for Enverus/ICE)

## Running VLR Calculations

### ERCOT VLR

**Location**: `ERCOT_VLR/VLR_ERCOT/`

**Option 1: Run Individual Scripts**

```bash
# Navigate to directory
cd ERCOT_VLR/VLR_ERCOT

# Run scripts in order
python DA_RT_LMPS.py          # Fetch LMP data
python DA_RT_LOAD.py          # Fetch load data
python Price_Variance.py       # Calculate price variance
python Load_Variance.py        # Calculate load variance
python Total_Hedge_Cost_WO_Imbalance.py
python Total_Cost_of_Imbalance.py
python Total_Hedge_Cost_W_Imbalance.py
python Total_Price_W_Imbalance.py
python Utilized_Cost.py
python Hourly_VLR.py           # Calculate hourly VLR
python ERCOT_VLR.py            # Final VLR calculation
```

**Option 2: Run All Scripts (Recommended)**

```bash
cd ERCOT_VLR/VLR_ERCOT
python Main.py
```

This executes all scripts in the correct order automatically.

### ISONE VLR

```bash
cd ISONE_VLR/VLR_ISONE_MOD
python Main.py
```

### MISO VLR

```bash
cd MISO_VLR
# Run individual scripts or create a main orchestrator
python miso_dataload.py
python hourly.py
python miso_vlr.py
# ... other scripts
```

### NYISO VLR

```bash
cd VLR_NYISO/VLR_NYISO_MOD
python Main.py
```

### PJM VLR

```bash
cd VLR_PJM/MOD_PY
python Main.py
```

## Running Shaping Calculations

### ERCOT Shaping

**Location**: `ERCOT_SHAPING/Scripts/`

```bash
cd ERCOT_SHAPING/Scripts
python main.py
```

Or run individually:

```bash
python da_lmps.py          # Fetch day-ahead LMPs
python da_lmps_avg.py       # Calculate averages
python ercot_shaping.py     # Calculate shaping costs
```

### Other ISOs

Follow the same pattern:

```bash
# ISONE
cd ISONE_SHAPING/Scripts
python main.py

# MISO
cd MISO_Shaping/Scripts
python main.py

# NYISO
cd NYISO_SHAPING/Scripts
python main.py

# PJM
cd PJM_SHAPING/Scripts
python main.py
```

## Running ICE Automation

**Location**: `ice_auto.py` (root directory)

### Manual Execution

```bash
# From project root
python ice_auto.py
```

### Automated Execution (GitHub Actions)

The project includes a GitHub Actions workflow (`.github/workflows/daily_ice_api.yml`) that runs automatically.

**To set up GitHub Actions:**

1. Ensure repository has GitHub Actions enabled
2. Add secrets to GitHub repository:
   - `EMAIL_SENDER`
   - `EMAIL_PASSWORD`
   - `EMAIL_RECEIVER`
3. Workflow runs daily (check schedule in YAML file)

### What ICE Automation Does

1. Downloads settlement reports from ICE:
   - Power cleared reports
   - Gas cleared reports
   - NGX (Natural Gas Exchange) reports
2. Sends email with attachments
3. Saves files to specified directory

## Running Streamlit Dashboard

### Local Development

```bash
# From project root
streamlit run ERCOT_VLR/SCALING_TOOL/Version_3_3.py
```

Or specify port and other options:

```bash
streamlit run ERCOT_VLR/SCALING_TOOL/Version_3_3.py \
    --server.port 8501 \
    --server.headless true
```

The dashboard will open in your browser at `http://localhost:8501`

### Features Available

1. **Data Fetching**: Download latest VLR data from database
2. **File Upload**: Upload Excel/CSV files for processing
3. **Scaling**: Apply scaling factors to zone data
4. **ABS Processing**: Convert values to absolute values
5. **Export**: Download processed data as CSV or XLSX

### Using the Dashboard

1. **Fetch Data**:
   - Click "Download" button to fetch latest data
   - Data is retrieved from PostgreSQL database
   - Exported as CSV or XLSX

2. **Process Files**:
   - Upload a file (Excel or CSV)
   - Configure scaling for each zone
   - Apply absolute value conversion if needed
   - Download processed file

## Running Complete Pipeline

### Manual Full Pipeline

For a complete data refresh across all ISOs:

```bash
# From project root
# Run all VLR calculations
python ERCOT_VLR/VLR_ERCOT/Main.py
python ISONE_VLR/VLR_ISONE_MOD/Main.py
python VLR_NYISO/VLR_NYISO_MOD/Main.py
python VLR_PJM/MOD_PY/Main.py

# Run all Shaping calculations
python ERCOT_SHAPING/Scripts/main.py
python ISONE_SHAPING/Scripts/main.py
python MISO_Shaping/Scripts/main.py
python NYISO_SHAPING/Scripts/main.py
python PJM_SHAPING/Scripts/main.py
```

### Using Shell Script (Linux/Mac)

The project includes `run_streamlit.sh` which can be modified:

```bash
# Make executable
chmod +x run_streamlit.sh

# Edit to match your Python path
# Then run:
./run_streamlit.sh
```

**Note**: Update the Python paths in the script to match your environment.

### Creating Your Own Orchestration Script

Create a `run_all.py` in the root directory:

```python
#!/usr/bin/env python
import subprocess
import sys

scripts = [
    ("ERCOT_VLR/VLR_ERCOT/Main.py", "ERCOT VLR"),
    ("ERCOT_SHAPING/Scripts/main.py", "ERCOT Shaping"),
    ("ISONE_VLR/VLR_ISONE_MOD/Main.py", "ISONE VLR"),
    ("ISONE_SHAPING/Scripts/main.py", "ISONE Shaping"),
    # Add more as needed
]

for script_path, description in scripts:
    print(f"\n{'='*50}")
    print(f"Running: {description}")
    print(f"{'='*50}")
    try:
        subprocess.run([sys.executable, script_path], check=True)
        print(f"✅ {description} completed successfully")
    except subprocess.CalledProcessError as e:
        print(f"❌ {description} failed with error: {e}")
        sys.exit(1)

print("\n✅ All pipelines completed successfully!")
```

Run with:

```bash
python run_all.py
```

## Scheduling & Automation

### Using Cron (Linux/Mac)

Edit crontab:

```bash
crontab -e
```

Add entries:

```cron
# Run ERCOT VLR daily at 2 AM
0 2 * * * cd /path/to/EPD_Automation && /path/to/venv/bin/python ERCOT_VLR/VLR_ERCOT/Main.py >> /path/to/logs/ercot_vlr.log 2>&1

# Run ERCOT Shaping daily at 3 AM
0 3 * * * cd /path/to/EPD_Automation && /path/to/venv/bin/python ERCOT_SHAPING/Scripts/main.py >> /path/to/logs/ercot_shaping.log 2>&1
```

### Using Task Scheduler (Windows)

1. Open Task Scheduler
2. Create Basic Task
3. Set trigger (daily, weekly, etc.)
4. Set action: Start a program
5. Program: `C:\path\to\python.exe`
6. Arguments: `ERCOT_VLR\VLR_ERCOT\Main.py`
7. Start in: `C:\path\to\EPD_Automation`

### Using GitHub Actions

Example workflow (`.github/workflows/daily_pipeline.yml`):

```yaml
name: Daily Pipeline

on:
  schedule:
    - cron: '0 2 * * *'  # Daily at 2 AM UTC
  workflow_dispatch:  # Manual trigger

jobs:
  run-pipeline:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.12'
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
      - name: Run ERCOT VLR
        env:
          DB_NAME: ${{ secrets.DB_NAME }}
          DB_USER: ${{ secrets.DB_USER }}
          DB_PASSWORD: ${{ secrets.DB_PASSWORD }}
          DB_HOST: ${{ secrets.DB_HOST }}
          DB_PORT: ${{ secrets.DB_PORT }}
        run: python ERCOT_VLR/VLR_ERCOT/Main.py
```

## Monitoring Execution

### Check Script Progress

Scripts print progress messages:

```
Fetching data for ERCOT_LZ_HOUSTON (Hierarchy ID: 1)...
Found last date: 2025-01-07. Start from 2025-01-08
Running DA_RT_LMPS.py...
Running DA_RT_LOAD.py...
✅ All scripts executed successfully!
```

### Check Database

Verify data was inserted:

```sql
-- Check latest data
SELECT MAX(date) FROM da_lmps_ercot;
SELECT COUNT(*) FROM ercot_vlr;

-- Check specific date range
SELECT * FROM ercot_vlr 
WHERE date BETWEEN '2025-01-01' AND '2025-01-31'
LIMIT 10;
```

### Check Logs

If using logging:

```bash
# View log files
tail -f logs/ercot_vlr.log
```

## Common Execution Issues

### Issue: Script fails with database error

**Solution**: 
- Check database is running
- Verify `.env` credentials
- Check database schema exists

### Issue: API rate limiting

**Solution**:
- Add delays between requests
- Use concurrent requests with limits
- Check API quota

### Issue: Script hangs

**Solution**:
- Check network connectivity
- Verify API endpoints are accessible
- Check database connection timeout settings

### Issue: Out of memory

**Solution**:
- Process data in smaller batches
- Clear pandas DataFrames after use
- Increase system memory

## Best Practices

1. **Run in Order**: Always run scripts in the correct sequence
2. **Check Dependencies**: Ensure previous steps completed successfully
3. **Monitor Resources**: Watch CPU and memory usage
4. **Log Everything**: Keep logs for troubleshooting
5. **Test First**: Test on small date ranges before full runs
6. **Backup Database**: Backup before major data loads

## Next Steps

- [Database Schema](05-database.md) - Understand data structure
- [Troubleshooting](09-troubleshooting.md) - Solve common issues
- [Deployment Guide](08-deployment.md) - Deploy to production

---

**Last Updated**: January 2025
