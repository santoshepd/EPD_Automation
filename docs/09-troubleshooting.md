# Troubleshooting Guide

This guide helps you resolve common issues when working with the EPD Automation system.

## Table of Contents

1. [Setup Issues](#setup-issues)
2. [Database Issues](#database-issues)
3. [API Issues](#api-issues)
4. [Streamlit Issues](#streamlit-issues)
5. [Deployment Issues](#deployment-issues)
6. [Performance Issues](#performance-issues)
7. [Data Issues](#data-issues)

## Setup Issues

### Issue: Python version mismatch

**Error**: `Python 3.12.2 required but 3.x.x found`

**Solutions**:
1. Install Python 3.12.2 or higher
2. Verify version: `python --version`
3. Use virtual environment with correct Python version
4. Update `requirements.txt` if version is flexible

### Issue: Package installation fails

**Error**: `ERROR: Could not install packages`

**Solutions**:
1. Upgrade pip: `pip install --upgrade pip`
2. Use virtual environment
3. Check internet connection
4. Try installing packages individually
5. On Windows, may need Visual C++ Build Tools for some packages

### Issue: psycopg2 installation fails

**Error**: `Error: pg_config executable not found`

**Solutions**:
1. Use `psycopg2-binary` instead (already in requirements.txt)
2. Uninstall `psycopg2`: `pip uninstall psycopg2`
3. Install binary version: `pip install psycopg2-binary`

### Issue: Module not found after installation

**Error**: `ModuleNotFoundError: No module named 'X'`

**Solutions**:
1. Verify virtual environment is activated
2. Reinstall requirements: `pip install -r requirements.txt`
3. Check Python path: `which python` or `where python`
4. Verify package name in `requirements.txt`

## Database Issues

### Issue: Database connection refused

**Error**: `psycopg2.OperationalError: could not connect to server`

**Solutions**:
1. **Check PostgreSQL is running**:
   ```bash
   # Linux/Mac
   pg_isready
   
   # Windows
   # Check Services → PostgreSQL
   ```

2. **Verify credentials in `.env`**:
   ```env
   DB_HOST=localhost  # or your actual host
   DB_PORT=5432
   DB_NAME=your_database
   DB_USER=your_user
   DB_PASSWORD=your_password
   ```

3. **Test connection manually**:
   ```bash
   psql -U your_user -d your_database -h localhost
   ```

4. **Check firewall settings**
5. **Verify PostgreSQL accepts connections** (check `pg_hba.conf`)

### Issue: Authentication failed

**Error**: `password authentication failed for user`

**Solutions**:
1. Verify username and password are correct
2. Check PostgreSQL user exists
3. Reset password if needed:
   ```sql
   ALTER USER your_user WITH PASSWORD 'new_password';
   ```

### Issue: Database does not exist

**Error**: `database "epd_automation" does not exist`

**Solutions**:
1. Create database:
   ```sql
   CREATE DATABASE epd_automation;
   ```

2. Run schema scripts:
   ```bash
   psql -U user -d epd_automation -f ERCOT_VLR/SQL/schemas.sql
   ```

### Issue: Table does not exist

**Error**: `relation "da_lmps_ercot" does not exist`

**Solutions**:
1. Run schema creation scripts
2. Verify you're connected to correct database
3. Check table name spelling
4. Verify schema scripts executed successfully

### Issue: Permission denied

**Error**: `permission denied for table`

**Solutions**:
1. Grant permissions:
   ```sql
   GRANT ALL PRIVILEGES ON DATABASE epd_automation TO your_user;
   GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO your_user;
   ```

2. Verify user has correct role
3. Check table ownership

## API Issues

### Issue: API authentication failed

**Error**: `401 Unauthorized` or `403 Forbidden`

**Solutions**:
1. Verify API credentials are correct
2. Check authorization header format
3. Ensure API key hasn't expired
4. Contact API provider for support
5. Check if credentials need to be refreshed

### Issue: Rate limit exceeded

**Error**: `429 Too Many Requests`

**Solutions**:
1. Reduce concurrent requests
2. Add delays between requests:
   ```python
   import time
   time.sleep(1)  # Wait 1 second between requests
   ```
3. Check API quota/limits
4. Upgrade API plan if needed
5. Implement exponential backoff

### Issue: Network timeout

**Error**: `requests.exceptions.Timeout`

**Solutions**:
1. Increase timeout:
   ```python
   response = requests.get(url, timeout=30)
   ```
2. Check network connectivity
3. Verify API endpoint is accessible
4. Implement retry logic:
   ```python
   from requests.adapters import HTTPAdapter
   from requests.packages.urllib3.util.retry import Retry
   
   session = requests.Session()
   retry = Retry(total=3, backoff_factor=0.3)
   adapter = HTTPAdapter(max_retries=retry)
   session.mount('http://', adapter)
   ```

### Issue: Data not available

**Error**: Empty response or no data returned

**Solutions**:
1. Verify date range is valid
2. Check symbol names are correct
3. Confirm data exists for requested period
4. Check API documentation for availability
5. Verify API endpoint hasn't changed

## Streamlit Issues

### Issue: App won't start

**Error**: `Streamlit app failed to start`

**Solutions**:
1. Check Python version: `python --version`
2. Verify Streamlit is installed: `pip show streamlit`
3. Check for syntax errors in Python file
4. Review Streamlit logs
5. Try running with verbose output:
   ```bash
   streamlit run app.py --logger.level=debug
   ```

### Issue: Database connection fails in Streamlit

**Error**: `Error connecting to database`

**Solutions**:
1. Check `.env` file exists and is configured
2. Verify Streamlit Cloud secrets (if deployed)
3. Test database connection outside Streamlit
4. Check RDS security group allows connections
5. Verify database credentials

### Issue: File upload fails

**Error**: `Error processing file`

**Solutions**:
1. Check file format (XLSX or CSV)
2. Verify file structure matches expected format
3. Check file size limits
4. Ensure file isn't corrupted
5. Try with a sample file first

### Issue: Data not displaying

**Error**: Empty data or no results

**Solutions**:
1. Check database has data
2. Verify query returns results
3. Check for errors in Streamlit logs
4. Test query manually in database
5. Verify date filters are correct

## Deployment Issues

### Issue: Deployment fails on Streamlit Cloud

**Error**: `Failed to install dependencies`

**Solutions**:
1. Check `requirements.txt` is correct
2. Ensure `psycopg2-binary` (not `psycopg2`)
3. Remove duplicate packages
4. Check Python version compatibility
5. Review deployment logs for specific errors

### Issue: App deployed but shows errors

**Error**: Runtime errors in deployed app

**Solutions**:
1. Check Streamlit Cloud logs
2. Verify secrets are configured
3. Test database connection
4. Check for environment-specific issues
5. Compare with local working version

### Issue: Database connection fails in production

**Error**: `Unable to connect to RDS` or `Connection timed out`

**Solutions**:
1. **Enable Public Accessibility**:
   - AWS Console → RDS → Your database → Modify
   - Connectivity → Public access → **Publicly accessible: Yes**
   - Apply changes immediately

2. **Update Security Group**:
   - EC2 → Security Groups → Find RDS security group
   - Edit inbound rules → Add rule:
     - Type: PostgreSQL
     - Port: 5432
     - Source: `0.0.0.0/0` (for testing) or specific IPs

3. **Verify Network ACLs**:
   - VPC → Network ACLs → Check inbound/outbound rules
   - Ensure port 5432 is allowed

4. **Verify RDS Endpoint**:
   - Use full endpoint: `your-db.xxxxx.region.rds.amazonaws.com`
   - Check port is 5432

5. **Test Connection Locally First**:
   ```bash
   psql -h your-rds-endpoint -U username -d database
   ```

6. **Check Streamlit Cloud Secrets**:
   - Verify `DB_HOST` is the full RDS endpoint
   - No quotes or extra spaces in TOML format

**See [RDS Connection Fix Guide](RDS_CONNECTION_FIX.md) for detailed steps.**

## Performance Issues

### Issue: Scripts run slowly

**Symptoms**: Long execution times

**Solutions**:
1. **Optimize database queries**:
   - Add indexes
   - Use efficient WHERE clauses
   - Limit result sets

2. **Reduce API calls**:
   - Use incremental updates
   - Cache responses when possible
   - Batch requests

3. **Optimize data processing**:
   - Use vectorized pandas operations
   - Process in chunks for large datasets
   - Clear unused DataFrames

4. **Use concurrent processing**:
   ```python
   from concurrent.futures import ThreadPoolExecutor
   # Process multiple items in parallel
   ```

### Issue: Out of memory

**Error**: `MemoryError` or system becomes unresponsive

**Solutions**:
1. Process data in smaller batches
2. Clear DataFrames after use:
   ```python
   del df
   import gc
   gc.collect()
   ```
3. Increase system memory
4. Use chunked processing for large files
5. Optimize data types (use appropriate dtypes)

### Issue: Database queries timeout

**Error**: `Query timeout` or slow queries

**Solutions**:
1. Add indexes on frequently queried columns
2. Optimize query structure
3. Use LIMIT for large result sets
4. Increase connection timeout
5. Consider query optimization or restructuring

## Data Issues

### Issue: Missing data

**Symptoms**: Gaps in data or missing dates

**Solutions**:
1. Check API data availability
2. Verify date ranges in queries
3. Check for data filtering issues
4. Review data insertion logs
5. Verify incremental update logic

### Issue: Incorrect calculations

**Symptoms**: Wrong VLR percentages or shaping costs

**Solutions**:
1. Verify source data is correct
2. Check calculation formulas
3. Review block type logic
4. Verify day type and hour type classifications
5. Test with known data points

### Issue: Duplicate data

**Symptoms**: Same data inserted multiple times

**Solutions**:
1. Use `ON CONFLICT` in INSERT statements
2. Check for duplicate API calls
3. Verify date range logic
4. Add unique constraints to tables
5. Review incremental update logic

## Getting Help

### Before Asking for Help

1. **Check logs**: Review error messages carefully
2. **Reproduce issue**: Can you reproduce it consistently?
3. **Check documentation**: Review relevant docs
4. **Search issues**: Check if others have similar problems
5. **Gather information**: Error messages, logs, system info

### Information to Provide

When reporting issues, include:

1. **Error message**: Full error traceback
2. **Environment**: OS, Python version, package versions
3. **Steps to reproduce**: What you did before the error
4. **Expected behavior**: What should happen
5. **Actual behavior**: What actually happened
6. **Logs**: Relevant log output
7. **Configuration**: `.env` settings (without passwords)

### Resources

- [Setup Guide](02-setup.md) - Installation help
- [Running Instructions](04-running.md) - Execution help
- [Database Schema](05-database.md) - Database structure
- [Deployment Guide](08-deployment.md) - Deployment help

## Common Error Messages

### `pg_config executable not found`
→ Use `psycopg2-binary` instead of `psycopg2`

### `could not connect to server`
→ Check PostgreSQL is running and credentials are correct

### `ModuleNotFoundError`
→ Install missing package or activate virtual environment

### `permission denied`
→ Grant database permissions to user

### `429 Too Many Requests`
→ Reduce API request rate or add delays

### `timeout`
→ Increase timeout or check network connectivity

---

**Last Updated**: January 2025
