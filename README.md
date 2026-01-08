# TLE-Automation


For the api_connection.py use this 'python api_connection.py FINAL_OG.xlsx RT_LMPS_Raw_Data' as the command

# ERCOT VLR Data Processing Pipeline

This project automates the extraction, transformation, and loading (ETL) of data from Enverus API into a PostgreSQL database to generate VLR Cost % Curve in ERCOT. It fetches **DAM LMPs**, **RTM LMPs**, **Actual and Forecasted Load values**, and organizes them into a structured schema.

# ERCOT Shaping Data Processing Pipeline

This project automates the extraction, transformation, and loading (ETL) of data from Enverus API into a PostgreSQL database to generate Shaping Cost % Curve in ERCOT. It fetches **DAM LMPs**, and organizes them into a structured schema.

## Features
- **Automated Data Extraction**: Fetches data from Enverus API for multiple load zones and timestamps.
- **Database Integration**: Stores and manages data in a PostgreSQL relational database.
- **Hierarchical Storage**: Data is stored in a multi-header format capturing detailed hierarchy information.

## Installation

### Prerequisites
Ensure you have the following installed:
- Python 3.12.2
- PostgreSQL
- `pip` package manager

### Install Dependencies
Run the following command to install required Python packages:
```bash
pip install -r requirements.txt

