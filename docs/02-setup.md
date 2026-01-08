# Setup & Installation Guide

This guide will help you set up the EPD Automation project from scratch on your local machine.

## Prerequisites

Before you begin, ensure you have the following installed:

### Required Software

1. **Python 3.12.2 or higher**
   - Download from [python.org](https://www.python.org/downloads/)
   - Verify installation: `python --version` or `python3 --version`

2. **PostgreSQL 12 or higher**
   - Download from [postgresql.org](https://www.postgresql.org/download/)
   - Create a database for the project
   - Note your database credentials (host, port, username, password, database name)

3. **Git**
   - Download from [git-scm.com](https://git-scm.com/downloads)
   - Verify: `git --version`

4. **Code Editor** (Recommended: VS Code or PyCharm)

### Optional but Recommended

- **PostgreSQL Client Tools** (pgAdmin or DBeaver) for database management
- **Virtual Environment Manager** (venv or conda)

## Step-by-Step Setup

### 1. Clone the Repository

```bash
# Clone the repository
git clone https://github.com/santoshepd/EPD_Automation.git

# Navigate to the project directory
cd EPD_Automation
```

### 2. Create a Virtual Environment

**Using venv (Recommended):**

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate
```

**Using conda:**

```bash
conda create -n epd_automation python=3.12
conda activate epd_automation
```

### 3. Install Dependencies

```bash
# Make sure you're in the project root directory
pip install -r requirements.txt
```

**Note**: If you encounter issues with `psycopg2`, use `psycopg2-binary` instead (already in requirements.txt).

### 4. Set Up Environment Variables

Create a `.env` file in the project root directory:

```bash
# Copy the example (if it exists) or create new
touch .env
```

Add the following variables to your `.env` file:

```env
# Database Configuration
DB_NAME=your_database_name
DB_USER=your_database_user
DB_PASSWORD=your_database_password
DB_HOST=localhost
DB_PORT=5432

# Email Configuration (for ICE automation)
EMAIL_SENDER=your_email@example.com
EMAIL_PASSWORD=your_email_password
EMAIL_RECEIVER=recipient@example.com

# ICE Download Directory (optional)
SAVE_DIR=/path/to/save/ice/files
```

**Important**: 
- Never commit the `.env` file to Git (it's already in `.gitignore`)
- Replace placeholder values with your actual credentials
- For production, use secure password management

### 5. Set Up PostgreSQL Database

#### Create Database

```sql
-- Connect to PostgreSQL
psql -U postgres

-- Create database
CREATE DATABASE epd_automation;

-- Connect to the new database
\c epd_automation
```

#### Run Schema Scripts

The project includes SQL scripts for each ISO. Run them in order:

**For ERCOT VLR:**
```bash
psql -U your_user -d your_database -f ERCOT_VLR/SQL/schemas.sql
psql -U your_user -d your_database -f ERCOT_VLR/SQL/hierarchy.sql
```

**For ERCOT Shaping:**
```bash
psql -U your_user -d your_database -f ERCOT_SHAPING/SQL/ERCOT_Shaping.sql
```

**For other ISOs**, follow the same pattern:
- `ISONE_VLR/ISONE_VLR.sql`
- `ISONE_SHAPING/SQL/ISONE_Shaping.sql`
- `MISO_VLR/schema_miso.sql`
- `NYISO_SHAPING/SQL/NYISO_Shaping.sql`
- `PJM_SHAPING/SQL/PJM_Shaping.sql`
- `VLR_NYISO/SQL/nyiso_full_script.sql`
- `VLR_PJM/SQL/pjm_full_script.sql`

### 6. Verify Installation

Test your setup:

```bash
# Test Python installation
python --version

# Test database connection
python -c "from dotenv import load_dotenv; import os; import psycopg2; load_dotenv(); conn = psycopg2.connect(dbname=os.getenv('DB_NAME'), user=os.getenv('DB_USER'), password=os.getenv('DB_PASSWORD'), host=os.getenv('DB_HOST'), port=os.getenv('DB_PORT')); print('Database connection successful!'); conn.close()"

# Test imports
python -c "import pandas, streamlit, psycopg2, sqlalchemy; print('All packages imported successfully!')"
```

### 7. Test Run a Simple Script

Test with a simple data fetch:

```bash
# Navigate to ERCOT VLR directory
cd ERCOT_VLR/VLR_ERCOT

# Run a single script (this will fetch data from API)
python DA_RT_LMPS.py
```

**Note**: This requires valid API credentials. See [Data Sources Documentation](06-data-sources.md) for API setup.

## Configuration Files

### `.env` File Structure

```env
# Database
DB_NAME=epd_automation
DB_USER=postgres
DB_PASSWORD=your_secure_password
DB_HOST=localhost
DB_PORT=5432

# Email (for ICE automation)
EMAIL_SENDER=noreply@yourcompany.com
EMAIL_PASSWORD=app_specific_password
EMAIL_RECEIVER=team@yourcompany.com

# Optional
SAVE_DIR=/path/to/downloads
```

### `requirements.txt` Overview

Key packages:
- `pandas`: Data manipulation
- `psycopg2-binary`: PostgreSQL adapter
- `sqlalchemy`: Database ORM
- `streamlit`: Web dashboard
- `python-dotenv`: Environment variable management
- `requests`: HTTP requests for APIs
- `numpy`: Numerical computations
- `XlsxWriter`, `openpyxl`: Excel file handling

## IDE Setup (VS Code)

### Recommended Extensions

1. **Python** (Microsoft)
2. **Pylance** (Microsoft)
3. **PostgreSQL** (Chris Kolkman)
4. **GitLens** (GitKraken)

### VS Code Settings

Create `.vscode/settings.json`:

```json
{
    "python.defaultInterpreterPath": "${workspaceFolder}/venv/bin/python",
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "python.formatting.provider": "black",
    "files.exclude": {
        "**/__pycache__": true,
        "**/*.pyc": true
    }
}
```

## Common Setup Issues

### Issue: `psycopg2` installation fails

**Solution**: Use `psycopg2-binary` instead (already in requirements.txt)

```bash
pip uninstall psycopg2
pip install psycopg2-binary
```

### Issue: Database connection refused

**Solutions**:
1. Check PostgreSQL is running: `pg_isready`
2. Verify credentials in `.env`
3. Check firewall settings
4. Ensure PostgreSQL accepts connections (check `pg_hba.conf`)

### Issue: Module not found errors

**Solutions**:
1. Ensure virtual environment is activated
2. Reinstall requirements: `pip install -r requirements.txt`
3. Check Python path: `which python` or `where python`

### Issue: Permission denied on SQL scripts

**Solution**: Ensure database user has CREATE privileges:

```sql
GRANT ALL PRIVILEGES ON DATABASE epd_automation TO your_user;
```

## Next Steps

After completing setup:

1. [Read Architecture Documentation](03-architecture.md) to understand project structure
2. [Review Running Instructions](04-running.md) to execute pipelines
3. [Check Database Schema](05-database.md) to understand data structure
4. [Set Up Data Sources](06-data-sources.md) for API access

## Development Environment Checklist

- [ ] Python 3.12+ installed
- [ ] PostgreSQL installed and running
- [ ] Repository cloned
- [ ] Virtual environment created and activated
- [ ] Dependencies installed
- [ ] `.env` file configured
- [ ] Database created
- [ ] Schema scripts executed
- [ ] Test connection successful
- [ ] IDE configured (optional)

## Getting Help

If you encounter issues during setup:

1. Check the [Troubleshooting Guide](09-troubleshooting.md)
2. Review error messages carefully
3. Verify all prerequisites are installed
4. Check database and API connectivity
5. Contact the development team

---

**Next**: [Architecture & Project Structure](03-architecture.md)
