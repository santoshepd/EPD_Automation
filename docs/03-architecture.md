# Architecture & Project Structure

This document explains the overall architecture and organization of the EPD Automation project.

## Project Structure

```
EPD_Automation/
├── docs/                          # Documentation (this folder)
├── .github/                       # GitHub workflows and actions
│   └── workflows/
│       └── daily_ice_api.yml      # Automated ICE data download
├── ERCOT_SHAPING/                 # ERCOT Shaping calculations
│   ├── Scripts/                  # Main processing scripts
│   │   ├── da_lmps.py            # Day-ahead LMP extraction
│   │   ├── da_lmps_avg.py        # Average LMP calculations
│   │   ├── ercot_shaping.py      # Shaping cost calculations
│   │   └── main.py               # Orchestration script
│   ├── SQL/                      # Database schemas
│   │   └── ERCOT_Shaping.sql
│   └── ERCOT_Shaping.ipynb       # Jupyter notebook for analysis
├── ERCOT_VLR/                    # ERCOT VLR calculations
│   ├── VLR_ERCOT/                # VLR processing scripts
│   │   ├── DA_RT_LMPS.py        # Day-ahead and real-time LMPs
│   │   ├── DA_RT_LOAD.py        # Day-ahead and real-time load
│   │   ├── Price_Variance.py    # Price variance calculations
│   │   ├── Load_Variance.py      # Load variance calculations
│   │   ├── Hourly_VLR.py        # Hourly VLR percentages
│   │   ├── ERCOT_VLR.py          # Final VLR calculations
│   │   └── Main.py               # Orchestration script
│   ├── SCALING_TOOL/             # Streamlit dashboard
│   │   ├── Streamlit.py          # Main dashboard
│   │   ├── Version_3_3.py        # Latest version
│   │   └── New_Streamlit.py      # Alternative version
│   └── SQL/                      # Database schemas
│       ├── schemas.sql           # Table definitions
│       └── hierarchy.sql         # Hierarchy structure
├── ISONE_SHAPING/                # ISO New England Shaping
├── ISONE_VLR/                    # ISO New England VLR
├── MISO_Shaping/                 # MISO Shaping
├── MISO_VLR/                     # MISO VLR
├── NYISO_SHAPING/                # NYISO Shaping
├── VLR_NYISO/                    # NYISO VLR
├── PJM_SHAPING/                  # PJM Shaping
├── VLR_PJM/                      # PJM VLR
├── ice_auto.py                    # ICE data download automation
├── requirements.txt               # Python dependencies
├── .env                           # Environment variables (not committed)
├── .gitignore                     # Git ignore rules
└── README.md                      # Project overview
```

## Architecture Overview

### High-Level Architecture

```
┌─────────────────┐
│  External APIs  │
│  (Enverus, ICE) │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   ETL Scripts   │
│   (Python)      │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   PostgreSQL    │
│    Database     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Streamlit App   │
│  (Dashboard)    │
└─────────────────┘
```

## Component Architecture

### 1. Data Extraction Layer

**Purpose**: Fetch data from external APIs

**Components**:
- `DA_RT_LMPS.py`: Fetches Day-Ahead and Real-Time LMPs
- `DA_RT_LOAD.py`: Fetches Day-Ahead and Real-Time Load data
- `ice_auto.py`: Downloads ICE settlement reports

**Key Features**:
- Incremental data fetching (only new data)
- Error handling and retries
- Concurrent requests for performance
- Data validation

### 2. Data Transformation Layer

**Purpose**: Process and transform raw data into calculated metrics

**Components**:
- `Price_Variance.py`: Calculates price differences
- `Load_Variance.py`: Calculates load differences
- `Hourly_VLR.py`: Computes hourly VLR percentages
- `*_shaping.py`: Calculates shaping costs

**Key Features**:
- Block type calculations (7x8, 5x16, etc.)
- Day type classification (weekday/weekend)
- Hour type classification (on-peak/off-peak)
- Percentage and absolute value calculations

### 3. Data Storage Layer

**Purpose**: Store processed data in structured format

**Components**:
- PostgreSQL database
- Hierarchical table structure
- Indexed for performance

**Key Features**:
- Relational data model
- Hierarchical organization
- Time-series data storage
- Efficient querying

### 4. Presentation Layer

**Purpose**: Provide user interface for data access and manipulation

**Components**:
- Streamlit dashboard (`Version_3_3.py`)
- Data export functionality
- Interactive scaling tools

**Key Features**:
- Real-time data visualization
- File upload and processing
- Data export (CSV, XLSX)
- User-friendly interface

## Data Flow Patterns

### VLR Calculation Flow

```
1. Fetch DA LMPs → Store in da_lmps_* table
2. Fetch RT LMPs → Store in rt_lmps_* table
3. Fetch DA Load → Store in da_load_* table
4. Fetch RT Load → Store in rt_load_* table
5. Calculate Price Variance → Store in price_variance table
6. Calculate Load Variance → Store in load_variance table
7. Calculate Hedge Costs → Store in hedge_cost tables
8. Calculate Total Costs → Store in total_cost tables
9. Calculate Hourly VLR → Store in hourly_vlr table
10. Calculate Final VLR → Store in final VLR table
```

### Shaping Calculation Flow

```
1. Fetch DA LMPs → Store in da_lmps_* table
2. Calculate Average LMPs → Store in da_lmps_avg table
3. Calculate Shaping Costs → Store in shaping table
4. Generate Cost Curves → Available for export
```

## ISO-Specific Modules

Each ISO (ERCOT, ISONE, MISO, NYISO, PJM) follows a similar structure:

### VLR Modules Structure

```
{ISO}_VLR/
├── VLR_{ISO}/ or MOD_PY/
│   ├── DA_RT_LMPS.py          # LMP data extraction
│   ├── DA_RT_LOAD.py           # Load data extraction
│   ├── Price_Variance.py       # Price calculations
│   ├── Load_Variance.py        # Load calculations
│   ├── Hourly_VLR.py          # Hourly metrics
│   ├── {ISO}_VLR.py            # Final calculations
│   └── Main.py                 # Orchestrator
└── SQL/
    └── schemas.sql             # Database schema
```

### Shaping Modules Structure

```
{ISO}_SHAPING/
├── Scripts/
│   ├── da_lmps.py             # LMP extraction
│   ├── da_lmps_avg.py          # Average calculations
│   ├── {iso}_shaping.py        # Shaping calculations
│   └── main.py                 # Orchestrator
└── SQL/
    └── {ISO}_Shaping.sql       # Database schema
```

## Database Architecture

### Hierarchical Structure

```
vlr_hierarchy table
├── Control Area
│   ├── State
│   │   ├── Load Zone
│   │   │   ├── Capacity Zone
│   │   │   │   ├── Utility
│   │   │   │   │   ├── Cost Group
│   │   │   │   │   │   └── Cost Component
```

### Key Tables

1. **Raw Data Tables**: Store API-fetched data
   - `da_lmps_*`, `rt_lmps_*`
   - `da_load_*`, `rt_load_*`

2. **Calculated Tables**: Store processed metrics
   - `price_variance_*`
   - `load_variance_*`
   - `hourly_vlr_*`

3. **Hierarchy Tables**: Store organizational structure
   - `vlr_hierarchy`
   - `*_hierarchy`

4. **Final Output Tables**: Store final calculations
   - `ercot_vlr`
   - `*_shaping`

## Design Patterns

### 1. Orchestration Pattern

Each module has a `Main.py` that orchestrates script execution:

```python
scripts = [
    "DA_RT_LMPS.py",
    "DA_RT_LOAD.py",
    "Price_Variance.py",
    # ... more scripts
]

for script in scripts:
    subprocess.run([python_path, script])
```

### 2. Incremental Processing

Scripts check for the last processed date and only fetch new data:

```python
def get_last_date(table_name):
    # Query database for MAX(date)
    # Return next date to process
```

### 3. Environment-Based Configuration

All scripts use `.env` for configuration:

```python
from dotenv import load_dotenv
load_dotenv()
DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    # ...
}
```

### 4. Error Handling

Consistent error handling across modules:

```python
try:
    # Database operation
except Exception as e:
    print(f"Error: {e}")
    # Log and continue or exit
```

## Scalability Considerations

### Current Limitations

- Sequential script execution
- Single database connection per script
- No distributed processing

### Future Improvements

- Parallel script execution
- Connection pooling
- Distributed processing for large datasets
- Caching layer for frequently accessed data

## Security Architecture

### Credential Management

- Environment variables (`.env`) for local development
- Streamlit Cloud secrets for production
- Never commit credentials to Git

### Database Security

- Parameterized queries (SQLAlchemy)
- Connection timeouts
- Access control via PostgreSQL roles

### API Security

- API keys stored in environment variables
- Secure HTTP connections (HTTPS)
- Rate limiting considerations

## Performance Optimization

### Database

- Indexed columns (date, hierarchy_id)
- Partitioned tables (by date, if needed)
- Connection pooling

### Data Processing

- Batch inserts
- Concurrent API requests
- Efficient pandas operations

### Caching

- Streamlit caching for expensive operations
- Database query result caching

## Monitoring & Logging

### Current State

- Print statements for progress
- Error messages to console
- No centralized logging

### Recommended Improvements

- Structured logging (Python `logging` module)
- Log aggregation service
- Performance metrics
- Error tracking (Sentry, etc.)

## Next Steps

- [Running Instructions](04-running.md) - How to execute the system
- [Database Schema](05-database.md) - Detailed database structure
- [Development Guide](10-development.md) - Contributing to the project

---

**Last Updated**: January 2025
