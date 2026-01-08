# EPD Automation - Complete Documentation

Welcome to the EPD (Energy Price Data) Automation project documentation. This comprehensive guide will help you understand, set up, and work with the entire system.

## 📚 Documentation Index

1. [Overview & Introduction](01-overview.md) - What this project does and its purpose
2. [Setup & Installation](02-setup.md) - Complete setup instructions for new developers
3. [Architecture & Project Structure](03-architecture.md) - How the project is organized
4. [Running the Application](04-running.md) - How to run each component
5. [Database Schema](05-database.md) - Database structure and schemas
6. [Data Sources & APIs](06-data-sources.md) - External APIs and data sources used
7. [Streamlit Application](07-streamlit.md) - Streamlit dashboard documentation
8. [Deployment Guide](08-deployment.md) - Deploying to Streamlit Cloud
9. [Troubleshooting](09-troubleshooting.md) - Common issues and solutions
10. [Development Guide](10-development.md) - Best practices and contribution guidelines
11. [RDS Connection Fix](RDS_CONNECTION_FIX.md) - **Quick fix for RDS connection timeouts**

## 🚀 Quick Start

If you're new to this project, start here:

1. **Read the [Overview](01-overview.md)** to understand what the project does
2. **Follow the [Setup Guide](02-setup.md)** to get your environment ready
3. **Check [Running Instructions](04-running.md)** to execute the pipelines
4. **Review [Architecture](03-architecture.md)** to understand the codebase structure

## 📋 Project Summary

This project automates the extraction, transformation, and loading (ETL) of energy market data from multiple sources:

- **VLR (Volumetric Load Risk) Calculations** for ERCOT, ISONE, MISO, NYISO, and PJM
- **Shaping Cost Calculations** for ERCOT, ISONE, MISO, NYISO, and PJM
- **ICE (Intercontinental Exchange) Data Downloads** for settlement reports
- **Streamlit Dashboard** for data visualization and scaling tools

## 🛠️ Technology Stack

- **Language**: Python 3.12+
- **Database**: PostgreSQL
- **Web Framework**: Streamlit
- **Data Processing**: Pandas, NumPy
- **APIs**: Enverus API, ICE API
- **Deployment**: Streamlit Cloud

## 📞 Support

For questions or issues:
1. Check the [Troubleshooting Guide](09-troubleshooting.md)
2. Review the relevant component documentation
3. Contact the development team

---

**Last Updated**: January 2025  
**Version**: 1.0
