# Data Sources & APIs

This document describes the external data sources and APIs used by the EPD Automation system.

## Overview

The system integrates with multiple external data sources:

1. **Enverus API** - Primary source for LMP and Load data
2. **ICE (Intercontinental Exchange)** - Settlement reports
3. **PostgreSQL Database** - Internal data storage

## Enverus API

### Overview

Enverus (formerly Drillinginfo) provides energy market data including:
- Day-Ahead LMPs (Locational Marginal Prices)
- Real-Time LMPs
- Day-Ahead Load forecasts
- Real-Time Load actuals

### Authentication

The system uses Basic Authentication:

```python
headers = {
    'Authorization': 'Basic VFJVRUFQSTphM3dTYVVSVA=='
}
```

**Note**: The authorization header contains base64-encoded credentials. In production, these should be stored securely in environment variables.

### API Endpoints

#### Fetching LMP Data

**Endpoint Pattern**: 
```
https://api.enverus.com/v3/direct-access/market-data/{symbol}
```

**Parameters**:
- `symbol`: Market symbol (e.g., `ERCOT_LZ_HOUSTON`)
- `startDate`: Start date (YYYY-MM-DD)
- `endDate`: End date (YYYY-MM-DD)
- `dataType`: 'DA' for Day-Ahead, 'RT' for Real-Time

**Example Request**:

```python
import requests

url = "https://api.enverus.com/v3/direct-access/market-data/ERCOT_LZ_HOUSTON"
params = {
    'startDate': '2025-01-01',
    'endDate': '2025-01-31',
    'dataType': 'DA'
}
headers = {
    'Authorization': 'Basic VFJVRUFQSTphM3dTYVVSVA=='
}

response = requests.get(url, params=params, headers=headers)
data = response.json()
```

#### Fetching Load Data

Similar endpoint structure with different `dataType` parameter.

### Rate Limiting

**Important**: Enverus API has rate limits. The system implements:

1. **Concurrent Requests**: Uses `ThreadPoolExecutor` for parallel requests
2. **Retry Logic**: Automatic retries on failures
3. **Error Handling**: Graceful handling of API errors

### Data Format

API returns JSON with structure:

```json
{
    "data": [
        {
            "date": "2025-01-01",
            "hour": 1,
            "value": 45.23
        },
        ...
    ]
}
```

### Symbol Mapping

Each ISO has specific symbols. Examples:

**ERCOT**:
- `ERCOT_LZ_HOUSTON`
- `ERCOT_LZ_WEST`
- `ERCOT_LZ_NORTH`
- etc.

**ISONE, MISO, NYISO, PJM**: Similar symbol patterns

### Implementation

See `ERCOT_VLR/VLR_ERCOT/DA_RT_LMPS.py` for implementation example:

```python
def fetch_single_symbol(symbol, hierarchy_id):
    try:
        url = f"https://api.enverus.com/v3/direct-access/market-data/{symbol}"
        params = {
            'startDate': start_date.strftime('%Y-%m-%d'),
            'endDate': end_date.strftime('%Y-%m-%d'),
            'dataType': 'DA'
        }
        response = requests.get(url, params=params, headers=headers)
        # Process response...
    except Exception as e:
        print(f"Error fetching {symbol}: {e}")
```

## ICE (Intercontinental Exchange)

### Overview

ICE provides settlement reports for:
- Power cleared transactions
- Natural gas cleared transactions
- NGX (Natural Gas Exchange) reports

### Authentication

ICE uses token-based authentication:

```python
login_info = {
    'userId': username,
    'password': password,
    'appKey': 'ICEDOWNLOADS'
}

auth_response = requests.post(
    'https://sso.ice.com/api/authenticateTfa', 
    login_info
)
token = auth_response.json()['result']['data']['token']
cookies = {'iceSsoCookie': token}
```

### File Download

**Endpoint Pattern**:
```
https://downloads.ice.com/{file_path}
```

**Example**:
```
https://downloads.ice.com/Settlement_Reports/Power/icecleared_power_2025_01_08.xlsx
```

### File Types

The system downloads:

1. **Power Reports**:
   - `icecleared_power_{date}.xlsx`
   - `ngxcleared_power_{date}.xlsx`

2. **Gas Reports**:
   - `icecleared_gas_{date}.xlsx`
   - `ngxcleared_gas_{date}.xlsx`

### Implementation

See `ice_auto.py` for complete implementation:

```python
def download_ice_file(username, password, file_path, save_dir):
    # Authenticate
    auth_response = requests.post('https://sso.ice.com/api/authenticateTfa', login_info)
    token = auth_response.json()['result']['data']['token']
    cookies = {'iceSsoCookie': token}
    
    # Download file
    download_url = f'https://downloads.ice.com/{file_path}'
    response = requests.get(download_url, cookies=cookies)
    
    # Save file
    with open(file_output_path, 'wb') as f:
        for chunk in response.iter_content(chunk_size=1024):
            f.write(chunk)
```

### Automation

ICE downloads are automated via:
- **GitHub Actions**: `.github/workflows/daily_ice_api.yml`
- **Cron Jobs**: Can be set up on local servers
- **Manual Execution**: `python ice_auto.py`

### Email Notification

After downloading, files are emailed to specified recipients using SMTP.

## Data Processing

### Incremental Updates

The system implements incremental data fetching:

```python
def get_last_date(table_name):
    conn = psycopg2.connect(**DB_PARAMS)
    cursor = conn.cursor()
    cursor.execute(f"SELECT MAX(date) FROM public.{table_name};")
    last_date = cursor.fetchone()[0]
    # Return next date to process
    return last_date + timedelta(days=1)
```

This ensures:
- Only new data is fetched
- Reduced API calls
- Faster processing

### Data Validation

Before inserting into database:

1. **Type Checking**: Ensure numeric values are valid
2. **Range Validation**: Hour Ending (1-24), dates within range
3. **Null Handling**: Skip or handle missing data
4. **Duplicate Detection**: Use `ON CONFLICT` for upserts

### Error Handling

```python
try:
    # API call
    response = requests.get(url, params=params, headers=headers)
    response.raise_for_status()
    # Process data
except requests.exceptions.HTTPError as e:
    print(f"HTTP Error: {e}")
except requests.exceptions.RequestException as e:
    print(f"Request Error: {e}")
except Exception as e:
    print(f"Unexpected Error: {e}")
```

## Configuration

### Environment Variables

Store API credentials in `.env`:

```env
# Enverus API (if using dynamic credentials)
ENVERUS_API_KEY=your_api_key
ENVERUS_API_SECRET=your_api_secret

# ICE Credentials
ICE_USERNAME=your_username
ICE_PASSWORD=your_password

# Email for ICE notifications
EMAIL_SENDER=your_email@example.com
EMAIL_PASSWORD=your_email_password
EMAIL_RECEIVER=recipient@example.com
```

### Secure Storage

**Never commit credentials to Git!**

- Use `.env` file (already in `.gitignore`)
- For production: Use Streamlit Cloud secrets
- For CI/CD: Use GitHub Secrets

## API Best Practices

### 1. Rate Limiting

- Implement delays between requests if needed
- Use concurrent requests with limits
- Monitor API quota usage

### 2. Error Handling

- Always check response status
- Implement retry logic with exponential backoff
- Log errors for debugging

### 3. Data Caching

- Cache API responses when possible
- Store data in database to avoid repeated API calls
- Use incremental updates

### 4. Monitoring

- Log API call success/failure rates
- Monitor response times
- Track data quality

## Troubleshooting

### Issue: API Authentication Failed

**Solutions**:
- Verify credentials are correct
- Check authorization header format
- Ensure API key hasn't expired
- Contact API provider for support

### Issue: Rate Limit Exceeded

**Solutions**:
- Reduce concurrent requests
- Add delays between requests
- Check API quota/limits
- Upgrade API plan if needed

### Issue: Data Not Available

**Solutions**:
- Verify date range is valid
- Check symbol names are correct
- Confirm data exists for requested period
- Check API documentation for availability

### Issue: Network Timeout

**Solutions**:
- Increase timeout settings
- Check network connectivity
- Implement retry logic
- Use connection pooling

## API Documentation References

- **Enverus API**: Contact Enverus for API documentation
- **ICE Downloads**: [ICE Downloads Portal](https://downloads.ice.com)
- **PostgreSQL**: [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## Next Steps

- [Running Instructions](04-running.md) - How to fetch data
- [Troubleshooting](09-troubleshooting.md) - API-related issues
- [Development Guide](10-development.md) - Adding new data sources

---

**Last Updated**: January 2025
