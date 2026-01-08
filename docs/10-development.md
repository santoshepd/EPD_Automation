# Development Guide

This guide helps developers contribute to and extend the EPD Automation project.

## Table of Contents

1. [Development Setup](#development-setup)
2. [Code Structure](#code-structure)
3. [Adding New Features](#adding-new-features)
4. [Adding New ISOs](#adding-new-isos)
5. [Best Practices](#best-practices)
6. [Testing](#testing)
7. [Code Style](#code-style)
8. [Git Workflow](#git-workflow)

## Development Setup

### Prerequisites

- Python 3.12+
- PostgreSQL 12+
- Git
- Code editor (VS Code recommended)

### Initial Setup

1. **Clone repository**:
   ```bash
   git clone https://github.com/santoshepd/EPD_Automation.git
   cd EPD_Automation
   ```

2. **Create virtual environment**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

4. **Set up `.env` file**:
   ```env
   DB_NAME=epd_automation
   DB_USER=postgres
   DB_PASSWORD=your_password
   DB_HOST=localhost
   DB_PORT=5432
   ```

5. **Set up database**:
   ```bash
   psql -U postgres -c "CREATE DATABASE epd_automation;"
   psql -U postgres -d epd_automation -f ERCOT_VLR/SQL/schemas.sql
   ```

## Code Structure

### Directory Organization

```
EPD_Automation/
├── {ISO}_VLR/              # VLR calculations for each ISO
│   ├── VLR_{ISO}/          # Processing scripts
│   │   ├── DA_RT_LMPS.py   # LMP data extraction
│   │   ├── DA_RT_LOAD.py   # Load data extraction
│   │   ├── Main.py         # Orchestrator
│   │   └── ...
│   └── SQL/                # Database schemas
├── {ISO}_SHAPING/          # Shaping calculations
│   ├── Scripts/            # Processing scripts
│   └── SQL/                # Database schemas
└── docs/                   # Documentation
```

### Common Patterns

#### 1. Data Extraction Script

```python
import os
from dotenv import load_dotenv
import requests
import pandas as pd
import psycopg2
from datetime import datetime, timedelta

# Load environment variables
load_dotenv()

DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}

headers = {
    'Authorization': 'Basic YOUR_AUTH_TOKEN'
}

def get_last_date(table_name):
    """Get the last processed date from database"""
    try:
        conn = psycopg2.connect(**DB_PARAMS)
        cursor = conn.cursor()
        cursor.execute(f"SELECT MAX(date) FROM public.{table_name};")
        last_date = cursor.fetchone()[0]
        cursor.close()
        conn.close()
        
        if last_date is None:
            return datetime(2020, 12, 1)  # Default start date
        else:
            return last_date + timedelta(days=1)
    except Exception as e:
        print(f"Error: {e}")
        return datetime(2020, 12, 1)

# Main execution
start_date = get_last_date("da_lmps_ercot")
end_date = datetime.now()

# Fetch and process data...
```

#### 2. Calculation Script

```python
import pandas as pd
from sqlalchemy import create_engine
import psycopg2
from dotenv import load_dotenv
import os

load_dotenv()

# Database connection
engine = create_engine(f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}")

# Query data
query = """
    SELECT * FROM source_table
    WHERE date >= '2025-01-01'
"""
df = pd.read_sql(query, engine)

# Process data
df['calculated_value'] = df['value1'] - df['value2']

# Insert into target table
conn = psycopg2.connect(**DB_PARAMS)
cursor = conn.cursor()

insert_query = """
    INSERT INTO target_table (hierarchy_id, date, he, data)
    VALUES (%(hierarchy_id)s, %(date)s, %(he)s, %(data)s)
    ON CONFLICT (hierarchy_id, date, he) 
    DO UPDATE SET data = EXCLUDED.data
"""

cursor.executemany(insert_query, df.to_dict(orient="records"))
conn.commit()
cursor.close()
conn.close()
```

#### 3. Main Orchestrator

```python
#!/usr/bin/env python
import subprocess
import sys

scripts = [
    "DA_RT_LMPS.py",
    "DA_RT_LOAD.py",
    "Price_Variance.py",
    # ... more scripts
]

for script in scripts:
    print(f"Running {script}...")
    try:
        subprocess.run([sys.executable, script], check=True)
        print(f"✅ {script} completed")
    except subprocess.CalledProcessError as e:
        print(f"❌ {script} failed: {e}")
        sys.exit(1)

print("✅ All scripts completed successfully!")
```

## Adding New Features

### 1. Adding a New Calculation

**Step 1**: Create new script file

```python
# New_Calculation.py
import pandas as pd
from sqlalchemy import create_engine
# ... imports

# Query source data
# Perform calculations
# Insert results
```

**Step 2**: Add to Main.py orchestrator

```python
scripts = [
    # ... existing scripts
    "New_Calculation.py",
]
```

**Step 3**: Create database table (if needed)

```sql
CREATE TABLE new_calculation_table (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    he INT NOT NULL,
    data NUMERIC(12, 5) NOT NULL
);
```

**Step 4**: Test the script

```bash
python New_Calculation.py
```

### 2. Adding New Streamlit Features

**Location**: `ERCOT_VLR/SCALING_TOOL/Version_3_3.py`

**Example**: Add a new visualization

```python
import streamlit as st
import altair as alt

# Add new section
st.header("New Visualization")

# Query data
df = fetch_data_for_visualization()

# Create chart
chart = alt.Chart(df).mark_line().encode(
    x='date:T',
    y='value:Q'
)

st.altair_chart(chart, use_container_width=True)
```

## Adding New ISOs

### Step 1: Create Directory Structure

```bash
mkdir -p NEWISO_VLR/VLR_NEWISO
mkdir -p NEWISO_VLR/SQL
mkdir -p NEWISO_SHAPING/Scripts
mkdir -p NEWISO_SHAPING/SQL
```

### Step 2: Create Database Schema

Create `NEWISO_VLR/SQL/schemas.sql`:

```sql
-- Similar structure to ERCOT_VLR/SQL/schemas.sql
CREATE TABLE da_lmps_newiso (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24),
    data NUMERIC(12, 5) NOT NULL
);
-- ... more tables
```

### Step 3: Create Data Extraction Scripts

Copy and modify from existing ISO:

```python
# NEWISO_VLR/VLR_NEWISO/DA_RT_LMPS.py
# Modify API endpoints, symbols, table names
```

### Step 4: Create Calculation Scripts

Follow the same pattern as existing ISOs.

### Step 5: Create Main Orchestrator

```python
# NEWISO_VLR/VLR_NEWISO/Main.py
scripts = [
    "DA_RT_LMPS.py",
    "DA_RT_LOAD.py",
    # ... more scripts
]
```

## Best Practices

### 1. Code Organization

- **Modular design**: Separate concerns (extraction, calculation, storage)
- **Reusable functions**: Create utility functions for common operations
- **Clear naming**: Use descriptive variable and function names
- **Comments**: Document complex logic

### 2. Error Handling

```python
try:
    # Operation
    result = perform_operation()
except SpecificError as e:
    print(f"Specific error occurred: {e}")
    # Handle specific error
except Exception as e:
    print(f"Unexpected error: {e}")
    # Handle general error
    raise  # Re-raise if needed
```

### 3. Database Operations

- **Use parameterized queries**: Prevent SQL injection
- **Handle conflicts**: Use `ON CONFLICT` for upserts
- **Close connections**: Always close database connections
- **Use transactions**: Group related operations

### 4. API Calls

- **Handle rate limits**: Implement retry logic
- **Error handling**: Check response status
- **Incremental updates**: Only fetch new data
- **Concurrent requests**: Use ThreadPoolExecutor for parallel requests

### 5. Data Processing

- **Validate data**: Check for nulls, ranges, types
- **Efficient operations**: Use vectorized pandas operations
- **Memory management**: Clear large DataFrames when done
- **Chunked processing**: Process large datasets in chunks

## Testing

### Manual Testing

1. **Test individual scripts**:
   ```bash
   python ERCOT_VLR/VLR_ERCOT/DA_RT_LMPS.py
   ```

2. **Verify database**:
   ```sql
   SELECT COUNT(*) FROM da_lmps_ercot;
   SELECT MAX(date) FROM da_lmps_ercot;
   ```

3. **Test calculations**:
   - Compare with known values
   - Check for reasonable ranges
   - Verify aggregations

### Unit Testing (Recommended)

Create `tests/` directory:

```python
# tests/test_calculations.py
import unittest
from ERCOT_VLR.VLR_ERCOT import Price_Variance

class TestCalculations(unittest.TestCase):
    def test_price_variance(self):
        # Test calculation logic
        result = calculate_price_variance(100, 90)
        self.assertEqual(result, 10)
```

Run tests:

```bash
python -m pytest tests/
```

## Code Style

### Python Style Guide

Follow PEP 8:

- **Indentation**: 4 spaces
- **Line length**: Maximum 100 characters
- **Naming**: 
  - Functions: `snake_case`
  - Classes: `PascalCase`
  - Constants: `UPPER_CASE`

### Formatting

Use `black` for code formatting:

```bash
pip install black
black your_file.py
```

### Linting

Use `pylint` or `flake8`:

```bash
pip install pylint
pylint your_file.py
```

## Git Workflow

### Branch Strategy

1. **Main branch**: Production-ready code
2. **Feature branches**: `feature/description`
3. **Bug fixes**: `fix/description`

### Commit Messages

Use clear, descriptive messages:

```
feat: Add NYISO VLR calculations
fix: Resolve database connection timeout
docs: Update deployment guide
refactor: Simplify price variance calculation
```

### Pull Request Process

1. Create feature branch
2. Make changes
3. Test thoroughly
4. Commit with clear messages
5. Push to GitHub
6. Create pull request
7. Request review
8. Merge after approval

## Documentation

### Code Documentation

Add docstrings to functions:

```python
def calculate_vlr(price_variance, load_variance):
    """
    Calculate VLR percentage from price and load variance.
    
    Args:
        price_variance (float): Price variance value
        load_variance (float): Load variance value
    
    Returns:
        float: VLR percentage
    """
    # Implementation
    return result
```

### Update Documentation

When adding features:

1. Update relevant documentation files
2. Add examples
3. Update diagrams if needed
4. Keep documentation in sync with code

## Performance Optimization

### Database

- Add indexes on frequently queried columns
- Use efficient WHERE clauses
- Limit result sets when possible

### Data Processing

- Use vectorized operations
- Process in chunks for large datasets
- Cache expensive calculations

### API Calls

- Use concurrent requests (with limits)
- Implement caching
- Use incremental updates

## Security

### Credentials

- Never commit credentials
- Use environment variables
- Rotate passwords regularly

### Input Validation

- Validate all inputs
- Sanitize user inputs
- Use parameterized queries

### Error Messages

- Don't expose sensitive information
- Provide helpful but secure error messages

## Resources

- [Python Documentation](https://docs.python.org/3/)
- [Pandas Documentation](https://pandas.pydata.org/docs/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Streamlit Documentation](https://docs.streamlit.io/)

## Next Steps

- Review existing code for patterns
- Start with small changes
- Test thoroughly
- Document your changes
- Follow the established patterns

---

**Last Updated**: January 2025
