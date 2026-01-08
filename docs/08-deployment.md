# Deployment Guide

This guide covers deploying the EPD Automation system to Streamlit Cloud.

## Overview

The system can be deployed to:
- **Streamlit Cloud** (Recommended for Streamlit app)
- **Local Server** (For ETL pipelines)
- **Cloud VMs** (AWS EC2, Azure VM, etc.)

## Streamlit Cloud Deployment

### Prerequisites

1. **GitHub Account**: Repository must be on GitHub
2. **Streamlit Cloud Account**: Sign up at [share.streamlit.io](https://share.streamlit.io)
3. **RDS Database**: Accessible from the internet (or use VPC peering)

### Step 1: Prepare Repository

Ensure your repository is ready:

```bash
# Verify requirements.txt is correct
cat requirements.txt

# Ensure .env is NOT committed (check .gitignore)
git check-ignore .env

# Commit all changes
git add .
git commit -m "Prepare for deployment"
git push origin main
```

### Step 2: Create Streamlit Cloud App

1. Go to [share.streamlit.io](https://share.streamlit.io)
2. Sign in with your GitHub account
3. Click **"New app"**
4. Configure:
   - **Repository**: Select `santoshepd/EPD_Automation`
   - **Branch**: `main`
   - **Main file path**: `ERCOT_VLR/SCALING_TOOL/Version_3_3.py`
   - **Python version**: `3.12` (or match your local version)
5. Click **"Deploy"**

### Step 3: Configure Secrets

1. In Streamlit Cloud, go to your app
2. Click **"Settings"** → **"Secrets"**
3. Add your database credentials:

```toml
DB_NAME = "your_database_name"
DB_USER = "your_database_user"
DB_PASSWORD = "your_database_password"
DB_HOST = "your-rds-endpoint.region.rds.amazonaws.com"
DB_PORT = "5432"
```

4. Click **"Save"**

### Step 4: Configure RDS Security

For Streamlit Cloud to connect to your RDS database:

#### Option A: Public RDS (Not Recommended for Production)

1. **Enable Public Accessibility**:
   - AWS Console → RDS → Your database
   - Modify → Connectivity → Publicly accessible: **Yes**

2. **Update Security Group**:
   - Go to Security Groups
   - Edit inbound rules
   - Add rule:
     - Type: PostgreSQL
     - Port: 5432
     - Source: `0.0.0.0/0` (or Streamlit Cloud IPs)

#### Option B: VPC Peering (Recommended)

1. Set up VPC peering between Streamlit Cloud and AWS
2. Keep RDS private
3. Configure security groups for peered VPC

#### Option C: RDS Proxy (Recommended for Production)

1. Create RDS Proxy in AWS
2. Configure security groups to allow Streamlit Cloud IPs
3. Use proxy endpoint in connection string

### Step 5: Verify Deployment

1. Check deployment logs in Streamlit Cloud
2. Test database connection
3. Verify app loads correctly
4. Test data fetching functionality

## Requirements.txt for Deployment

Ensure `requirements.txt` uses `psycopg2-binary`:

```txt
requests
pandas
psycopg2-binary
sqlalchemy
numpy
python-dotenv
streamlit
XlsxWriter
openpyxl
streamlit-autorefresh
streamlit-toggle-switch
altair
```

**Important**: Use `psycopg2-binary` (not `psycopg2`) for Streamlit Cloud.

## Environment Configuration

### Local Development

Use `.env` file:

```env
DB_NAME=epd_automation
DB_USER=postgres
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432
```

### Streamlit Cloud

Use Secrets (configured in Step 3 above).

### Code Support

The application supports both:

```python
# Try Streamlit Cloud secrets first
if hasattr(st, 'secrets') and 'DB_NAME' in st.secrets:
    db_params = {
        'dbname': st.secrets['DB_NAME'],
        # ...
    }
else:
    # Fall back to environment variables
    db_params = {
        'dbname': os.getenv("DB_NAME"),
        # ...
    }
```

## Deployment Checklist

- [ ] Repository pushed to GitHub
- [ ] `requirements.txt` uses `psycopg2-binary`
- [ ] `.env` file NOT committed to Git
- [ ] Streamlit Cloud app created
- [ ] Secrets configured in Streamlit Cloud
- [ ] RDS security group allows connections
- [ ] RDS is publicly accessible (or VPC peering configured)
- [ ] App deployed successfully
- [ ] Database connection tested
- [ ] Application functionality verified

## Troubleshooting Deployment

### Issue: Deployment fails with dependency error

**Error**: `Failed to download and build psycopg2`

**Solution**: 
- Ensure `requirements.txt` has `psycopg2-binary` (not `psycopg2`)
- Remove `psycopg2` if both are present

### Issue: Database connection fails

**Error**: `Unable to connect to database`

**Solutions**:
1. Verify secrets are correctly set in Streamlit Cloud
2. Check RDS security group allows connections
3. Verify RDS endpoint is correct
4. Test connection from local machine first
5. Check firewall rules

### Issue: Module not found

**Error**: `ModuleNotFoundError: No module named 'X'`

**Solutions**:
1. Verify package is in `requirements.txt`
2. Check package name is correct
3. Redeploy the app
4. Check deployment logs for installation errors

### Issue: App loads but shows errors

**Solutions**:
1. Check Streamlit Cloud logs
2. Verify database has data
3. Check for Python errors in logs
4. Test database queries manually

## Continuous Deployment

### Automatic Updates

Streamlit Cloud automatically redeploys when you push to the main branch.

### Manual Redeploy

1. Go to Streamlit Cloud dashboard
2. Click **"..."** menu on your app
3. Select **"Redeploy"**

## Monitoring

### View Logs

1. Go to Streamlit Cloud dashboard
2. Click on your app
3. Click **"Logs"** tab
4. View real-time logs

### Common Log Messages

- **Success**: `✅ Data inserted successfully`
- **Error**: `❌ Error connecting to database`
- **Info**: `Fetching data for...`

## Security Best Practices

### 1. Credential Management

- ✅ Use Streamlit Cloud secrets (never hardcode)
- ✅ Rotate passwords regularly
- ✅ Use strong passwords
- ❌ Never commit credentials to Git

### 2. Database Security

- ✅ Use RDS with encryption
- ✅ Restrict security group access
- ✅ Use VPC peering when possible
- ✅ Enable SSL connections

### 3. Application Security

- ✅ Validate all inputs
- ✅ Use parameterized queries
- ✅ Handle errors gracefully
- ✅ Implement rate limiting (if needed)

## Performance Optimization

### Database Connection

```python
engine = create_engine(
    connection_string,
    pool_pre_ping=True,      # Verify connections
    pool_recycle=3600,       # Recycle after 1 hour
    connect_args={"connect_timeout": 10}
)
```

### Caching

Use Streamlit caching for expensive operations:

```python
@st.cache_data
def fetch_data():
    # Expensive operation
    return data
```

## Alternative Deployment Options

### Local Server Deployment

For ETL pipelines (not Streamlit app):

```bash
# Set up as systemd service
sudo nano /etc/systemd/system/epd-automation.service

[Unit]
Description=EPD Automation ETL Pipeline
After=network.target

[Service]
Type=simple
User=your_user
WorkingDirectory=/path/to/EPD_Automation
ExecStart=/path/to/venv/bin/python ERCOT_VLR/VLR_ERCOT/Main.py
Restart=always

[Install]
WantedBy=multi-user.target
```

### Docker Deployment

Create `Dockerfile`:

```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["streamlit", "run", "ERCOT_VLR/SCALING_TOOL/Version_3_3.py", "--server.port=8501", "--server.address=0.0.0.0"]
```

Build and run:

```bash
docker build -t epd-automation .
docker run -p 8501:8501 epd-automation
```

## Rollback Procedure

If deployment fails:

1. **Revert Code**:
   ```bash
   git revert HEAD
   git push origin main
   ```

2. **Redeploy**: Streamlit Cloud will automatically redeploy

3. **Check Previous Version**: Review what changed

## Next Steps

- [Troubleshooting Guide](09-troubleshooting.md) - Common issues
- [Streamlit Documentation](07-streamlit.md) - App details
- [Development Guide](10-development.md) - Making changes

---

**Last Updated**: January 2025
