# Streamlit Application Documentation

This document describes the Streamlit dashboard application for the EPD Automation system.

## Overview

The Streamlit dashboard (`Version_3_3.py`) provides an interactive web interface for:
- Viewing and downloading VLR data
- Processing and scaling data files
- Applying ABS (Absolute Value) transformations
- Exporting processed data

## Location

**Main Application**: `ERCOT_VLR/SCALING_TOOL/Version_3_3.py`

**Alternative Versions**:
- `Streamlit.py` - Original version
- `New_Streamlit.py` - Alternative implementation
- `Version_3_2.py` - Previous version

## Features

### 1. Data Fetching and Download

**Functionality**:
- Fetches latest VLR data from PostgreSQL database
- Merges data with hierarchy information
- Creates pivot tables for easy viewing
- Exports data as CSV or XLSX

**Usage**:
1. Click "Download" button
2. Wait for data to be fetched
3. Download as CSV or XLSX format

### 2. File Upload and Processing

**Functionality**:
- Upload Excel (.xlsx) or CSV files
- Apply scaling factors to zone columns
- Convert values to absolute values
- Download processed files

**Usage**:
1. Upload a file using the file uploader
2. Configure scaling for each zone (percentage)
3. Optionally apply absolute value conversion
4. Download the processed file

### 3. Interactive Scaling

**Features**:
- Per-zone scaling configuration
- Scaling range: 100% to 500%
- Step size: 10%
- Real-time preview of changes

### 4. ABS (Absolute Value) Processing

**Features**:
- Toggle absolute value conversion per zone
- Preserves original data structure
- Applies to all numeric values in zone columns

## Running the Application

### Local Development

```bash
# From project root
streamlit run ERCOT_VLR/SCALING_TOOL/Version_3_3.py
```

The application will open in your browser at `http://localhost:8501`

### With Custom Port

```bash
streamlit run ERCOT_VLR/SCALING_TOOL/Version_3_3.py --server.port 8502
```

### Production Mode

```bash
streamlit run ERCOT_VLR/SCALING_TOOL/Version_3_3.py \
    --server.port 8501 \
    --server.headless true \
    --server.enableCORS false \
    --server.enableXsrfProtection false \
    --server.address 0.0.0.0
```

## Application Structure

### Imports and Setup

```python
import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
from io import BytesIO
import os
from dotenv import load_dotenv
```

### Database Connection

The app supports both local `.env` and Streamlit Cloud secrets:

```python
# Try Streamlit Cloud secrets first
if hasattr(st, 'secrets') and 'DB_NAME' in st.secrets:
    db_params = {
        'dbname': st.secrets['DB_NAME'],
        'user': st.secrets['DB_USER'],
        'password': st.secrets['DB_PASSWORD'],
        'host': st.secrets['DB_HOST'],
        'port': st.secrets['DB_PORT']
    }
else:
    # Fall back to environment variables
    db_params = {
        'dbname': os.getenv("DB_NAME"),
        'user': os.getenv("DB_USER"),
        'password': os.getenv("DB_PASSWORD"),
        'host': os.getenv("DB_HOST"),
        'port': os.getenv("DB_PORT")
    }
```

### Main Functions

#### `fetch_data()`

Fetches and processes VLR data from database:

```python
def fetch_data():
    # Query data and hierarchy tables
    # Merge data
    # Create pivot table
    # Return processed DataFrame
```

#### File Processing

Processes uploaded files with scaling and ABS:

```python
# Detect zone columns
zone_columns = [col for col in df.columns if "ZONE" in col.upper()]

# Apply scaling
df[zone] = df[zone].astype(float) * settings["scaler"]

# Apply ABS if selected
if settings["abs"] == "Yes":
    df[zone] = df[zone].abs()
```

## User Interface

### Page Configuration

```python
st.set_page_config(
    page_title="EPDC Automation",
    layout="wide"
)
```

### Custom CSS

The app includes custom CSS for:
- Title styling
- Button sizing
- Data frame borders
- Zone card styling
- Scrollable containers

### Layout Structure

1. **Title Section**: Centered title with styling
2. **Data Fetching Section**: Download button and export options
3. **File Upload Section**: File uploader and processing controls
4. **Zone Configuration**: Per-zone scaling and ABS settings
5. **Data Preview**: Display processed data
6. **Download Section**: Export processed files

## Data Processing Logic

### Pivot Table Creation

```python
pivot_df = pd.pivot_table(
    merged_df,
    values='data',
    index=['month', 'he', 'day_type', 'hour_type', 'block_type'],
    columns=['control_area', 'state', 'load_zone', ...],
    aggfunc='first'
)
```

### File Format Detection

```python
if uploaded_file.name.endswith('.xlsx'):
    original_df = pd.read_excel(uploaded_file)
    start = 9  # Skip header rows
else:
    original_df = pd.read_csv(uploaded_file)
    start = 8
```

### Column Processing

```python
# Process column names
df.columns = (
    ["control_area", "month", "he", "day_type", "hour_type", "block_type"] +
    list(df.iloc[1, 6:])
)

# Remove header rows
df = df.iloc[start:, 1:].reset_index(drop=True)
```

## Configuration

### Environment Variables

Required for local development:

```env
DB_NAME=your_database
DB_USER=your_user
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432
```

### Streamlit Cloud Secrets

For production deployment, configure in Streamlit Cloud:

```toml
DB_NAME = "your_database"
DB_USER = "your_user"
DB_PASSWORD = "your_password"
DB_HOST = "your-rds-endpoint.region.rds.amazonaws.com"
DB_PORT = "5432"
```

## Dependencies

Required packages (from `requirements.txt`):

- `streamlit`: Web framework
- `pandas`: Data manipulation
- `sqlalchemy`: Database ORM
- `psycopg2-binary`: PostgreSQL adapter
- `python-dotenv`: Environment variables
- `XlsxWriter`: Excel file writing
- `openpyxl`: Excel file reading
- `altair`: Data visualization (if used)

## Performance Optimization

### Caching

Use Streamlit caching for expensive operations:

```python
@st.cache_data
def fetch_data():
    # Expensive database query
    return data

@st.cache_resource
def get_database_connection():
    # Database connection
    return engine
```

### Connection Pooling

```python
engine = create_engine(
    connection_string,
    pool_pre_ping=True,
    pool_recycle=3600
)
```

## Error Handling

### Database Connection Errors

```python
try:
    engine = create_engine(...)
except Exception as e:
    st.error(f"❌ Error connecting to database: {str(e)}")
    st.info("💡 Make sure your RDS database is accessible and credentials are correct.")
    st.stop()
```

### Data Validation

```python
if not all([db_params['dbname'], db_params['user'], ...]):
    st.error("❌ Database credentials are missing!")
    st.stop()
```

## Deployment

See [Deployment Guide](08-deployment.md) for:
- Streamlit Cloud setup
- Environment configuration
- RDS connection setup
- Troubleshooting deployment issues

## Customization

### Adding New Features

1. Add new section with `st.header()` or `st.markdown()`
2. Add input widgets (sliders, selectboxes, etc.)
3. Process data based on inputs
4. Display results or download options

### Styling

Modify the CSS in the `st.markdown()` section:

```python
st.markdown("""
    <style>
        .custom-class {
            /* Your CSS here */
        }
    </style>
""", unsafe_allow_html=True)
```

## Troubleshooting

### Issue: Database connection fails

**Solutions**:
- Check `.env` file or Streamlit Cloud secrets
- Verify database is accessible
- Check firewall rules
- Verify credentials

### Issue: File upload fails

**Solutions**:
- Check file format (XLSX or CSV)
- Verify file structure matches expected format
- Check file size limits

### Issue: Data not displaying

**Solutions**:
- Check database has data
- Verify query returns results
- Check for errors in Streamlit logs

### Issue: Performance issues

**Solutions**:
- Implement caching
- Optimize database queries
- Process data in smaller chunks
- Use connection pooling

## Best Practices

1. **Error Handling**: Always handle errors gracefully
2. **User Feedback**: Provide clear messages to users
3. **Data Validation**: Validate inputs before processing
4. **Performance**: Cache expensive operations
5. **Security**: Never expose credentials in code
6. **Testing**: Test with various file formats and data sizes

## Next Steps

- [Deployment Guide](08-deployment.md) - Deploy to Streamlit Cloud
- [Troubleshooting](09-troubleshooting.md) - Common issues
- [Development Guide](10-development.md) - Extending the application

---

**Last Updated**: January 2025
