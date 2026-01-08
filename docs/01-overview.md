# Overview & Introduction

## What is EPD Automation?

EPD Automation is a comprehensive data processing pipeline system designed to automate the collection, processing, and analysis of energy market data from multiple Independent System Operators (ISOs) in the United States. The system calculates critical financial metrics including Volumetric Load Risk (VLR) and Shaping costs for energy trading and risk management.

## Purpose

The primary purpose of this system is to:

1. **Automate Data Collection**: Fetch real-time and historical energy market data from various APIs
2. **Calculate Financial Metrics**: Compute VLR percentages and Shaping costs for different ISOs
3. **Store Structured Data**: Organize data in a PostgreSQL database with hierarchical relationships
4. **Provide Analytics**: Offer interactive dashboards for data visualization and manipulation
5. **Enable Decision Making**: Support energy trading and risk management decisions

## Supported ISOs (Independent System Operators)

The system processes data for five major ISOs:

1. **ERCOT** (Electric Reliability Council of Texas)
2. **ISONE** (ISO New England)
3. **MISO** (Midcontinent Independent System Operator)
4. **NYISO** (New York Independent System Operator)
5. **PJM** (PJM Interconnection)

## Key Components

### 1. VLR (Volumetric Load Risk) Calculations

VLR calculations measure the financial risk associated with load forecasting errors. The system calculates:

- **Day-Ahead (DA) vs Real-Time (RT) Price Differences**: Price variance between forecasted and actual prices
- **Load Variance**: Difference between forecasted and actual load
- **Hedge Costs**: Costs with and without imbalance
- **Total Cost of Imbalance**: Financial impact of load forecasting errors
- **Hourly VLR**: VLR percentage calculated on an hourly basis

### 2. Shaping Calculations

Shaping costs represent the additional costs incurred when actual load patterns differ from day-ahead forecasts. The system calculates:

- **Day-Ahead LMPs (Locational Marginal Prices)**: Forecasted prices
- **Average LMPs**: Aggregated price data
- **Shaping Cost Curves**: Cost percentage curves for different load zones

### 3. Data Sources

- **Enverus API**: Primary source for LMP and load data
- **ICE (Intercontinental Exchange)**: Settlement reports for power and gas
- **PostgreSQL Database**: Centralized data storage

### 4. Streamlit Dashboard

Interactive web application providing:
- Data visualization
- VLR data download and export
- Scaling and ABS (Absolute Value) processing tools
- Real-time data updates

## Data Flow

```
External APIs (Enverus, ICE)
    ↓
ETL Scripts (Python)
    ↓
PostgreSQL Database
    ↓
Streamlit Dashboard
    ↓
End Users (Analysts, Traders)
```

## Key Features

### Automated ETL Pipelines
- Scheduled data extraction from APIs
- Automatic incremental updates (only fetches new data)
- Error handling and retry mechanisms
- Data validation and cleaning

### Hierarchical Data Organization
- Multi-level hierarchy: Control Area → State → Load Zone → Capacity Zone → Utility
- Supports complex organizational structures
- Enables granular analysis at different levels

### Scalable Architecture
- Modular design for easy maintenance
- Separate modules for each ISO
- Reusable components across different markets

### Interactive Analytics
- Real-time data visualization
- Customizable scaling and processing
- Export capabilities (CSV, XLSX)
- User-friendly interface

## Use Cases

1. **Risk Management**: Calculate and monitor VLR percentages to assess financial exposure
2. **Trading Decisions**: Use shaping cost curves to inform trading strategies
3. **Forecast Analysis**: Compare day-ahead forecasts with actual outcomes
4. **Cost Analysis**: Understand the financial impact of load forecasting errors
5. **Market Analysis**: Analyze price and load patterns across different ISOs

## Business Value

- **Time Savings**: Automates manual data collection and processing
- **Accuracy**: Reduces human error in calculations
- **Real-time Insights**: Provides up-to-date market information
- **Scalability**: Handles multiple ISOs and large datasets
- **Decision Support**: Enables data-driven trading and risk management decisions

## System Requirements

- **Python**: 3.12.2 or higher
- **PostgreSQL**: 12 or higher
- **Memory**: Minimum 4GB RAM (8GB recommended)
- **Storage**: Depends on data retention requirements
- **Network**: Internet connection for API access

## Next Steps

- [Setup Guide](02-setup.md) - Get your development environment ready
- [Architecture](03-architecture.md) - Understand the project structure
- [Running Instructions](04-running.md) - Learn how to execute the pipelines
