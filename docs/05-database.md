# Database Schema Documentation

This document describes the database structure, tables, and relationships in the EPD Automation system.

## Database Overview

The system uses **PostgreSQL** as the primary database. Data is organized hierarchically and stored in time-series format.

## Database Connection

### Connection Parameters

All scripts use environment variables for database connection:

```python
DB_PARAMS = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}
```

### Connection String Format

```
postgresql://user:password@host:port/database
```

## Schema Organization

### ISO-Specific Schemas

Each ISO has its own set of tables:

- **ERCOT**: `ercot_vlr_*`, `ercot_shaping_*`
- **ISONE**: `isone_vlr_*`, `isone_shaping_*`
- **MISO**: `miso_vlr_*`, `miso_shaping_*`
- **NYISO**: `nyiso_vlr_*`, `nyiso_shaping_*`
- **PJM**: `pjm_vlr_*`, `pjm_shaping_*`

## Core Table Structures

### 1. Hierarchy Tables

**Purpose**: Store organizational hierarchy (Control Area → State → Load Zone → etc.)

**Example**: `vlr_hierarchy` (ERCOT)

```sql
CREATE TABLE vlr_hierarchy (
    id SERIAL PRIMARY KEY,
    control_area VARCHAR(255),
    state VARCHAR(255),
    load_zone VARCHAR(255),
    capacity_zone VARCHAR(255),
    utility VARCHAR(255),
    block_type VARCHAR(50),
    cost_group VARCHAR(255),
    cost_component VARCHAR(255),
    uom VARCHAR(50)
);
```

**Key Fields**:
- `id`: Primary key, referenced by data tables
- Hierarchical fields: `control_area`, `state`, `load_zone`, etc.
- Metadata: `uom` (Unit of Measure)

### 2. Raw Data Tables

**Purpose**: Store API-fetched raw data

#### Day-Ahead LMPs

```sql
CREATE TABLE da_lmps_ercot (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24),
    data NUMERIC(12, 5) NOT NULL
);
```

#### Real-Time LMPs

```sql
CREATE TABLE rt_lmps_ercot (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24),
    data NUMERIC(12, 5) NOT NULL
);
```

#### Load Data Tables

```sql
CREATE TABLE da_wz_ercot (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24),
    data NUMERIC(12, 5) NOT NULL
);

CREATE TABLE rt_wz_ercot (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24),
    data NUMERIC(12, 5) NOT NULL
);
```

**Common Fields**:
- `hierarchy_id`: Foreign key to hierarchy table
- `date`: Date of the data point
- `he`: Hour Ending (1-24)
- `data`: Numeric value (LMP or Load)

### 3. Calculated Tables

#### Price Variance

```sql
CREATE TABLE price_variance_ercot (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    he INT NOT NULL,
    data NUMERIC(12, 5) NOT NULL
);
```

**Calculation**: `RT_LMP - DA_LMP`

#### Load Variance

```sql
CREATE TABLE load_variance_ercot (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    he INT NOT NULL,
    data NUMERIC(12, 5) NOT NULL
);
```

**Calculation**: `RT_Load - DA_Load`

#### Hourly VLR

```sql
CREATE TABLE ercot_vlr_hourly_cost (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    year INT,
    month INT,
    day INT,
    day_type VARCHAR(10),      -- 'WeekDay' or 'WeekEnd'
    he INT NOT NULL,
    hour_type VARCHAR(10),      -- 'OnPeak' or 'OffPeak'
    block_type VARCHAR(10),     -- '5x16', '2x16', '7x8'
    data NUMERIC(12, 6) NOT NULL
);
```

**Key Fields**:
- `day_type`: WeekDay or WeekEnd
- `hour_type`: OnPeak (7-22) or OffPeak
- `block_type`: 5x16, 2x16, or 7x8
- `data`: VLR percentage

#### Final VLR Table

```sql
CREATE TABLE ercot_vlr (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    month INT NOT NULL,
    he INT NOT NULL,
    day_type VARCHAR(10),
    hour_type VARCHAR(10),
    block_type VARCHAR(10),
    data NUMERIC(12, 6) NOT NULL
);
```

**Structure**: Aggregated by month, hour, day type, hour type, and block type.

### 4. Shaping Tables

#### Day-Ahead LMPs Average

```sql
CREATE TABLE ercot_shaping_da_lmps_avg (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    year INT,
    month INT,
    day INT,
    day_type VARCHAR(10),
    he INT NOT NULL,
    hour_type VARCHAR(10),
    block_type VARCHAR(10),
    data NUMERIC(12, 6) NOT NULL
);
```

#### Final Shaping Table

```sql
CREATE TABLE ercot_shaping (
    id SERIAL PRIMARY KEY,
    hierarchy_id INT NOT NULL,
    date DATE NOT NULL,
    year INT,
    month INT,
    day INT,
    day_type VARCHAR(10),
    he INT NOT NULL,
    hour_type VARCHAR(10),
    block_type VARCHAR(10),
    data NUMERIC(12, 6) NOT NULL,
    UNIQUE(hierarchy_id, date, he, block_type)
);
```

## Data Types

### Numeric Precision

- **LMPs and Loads**: `NUMERIC(12, 5)` - Up to 12 digits, 5 decimal places
- **Percentages**: `NUMERIC(12, 6)` - Up to 12 digits, 6 decimal places

### Date Handling

- **Date**: `DATE` type for date storage
- **Hour Ending**: `INT` with CHECK constraint (1-24)
- **Derived Fields**: `year`, `month`, `day` stored as INT

### Classification Fields

- **day_type**: `VARCHAR(10)` - 'WeekDay' or 'WeekEnd'
- **hour_type**: `VARCHAR(10)` - 'OnPeak' or 'OffPeak'
- **block_type**: `VARCHAR(10)` - '5x16', '2x16', or '7x8'

## Block Type Logic

Block types are calculated based on day type and hour type:

```python
def calculate_block_type(row):
    if row["day_type"] == "WeekDay" and row["hour_type"] == "OnPeak":
        return "5x16"  # 5 weekdays × 16 on-peak hours
    elif row["day_type"] == "WeekEnd" and row["hour_type"] == "OnPeak":
        return "2x16"  # 2 weekend days × 16 on-peak hours
    else:
        return "7x8"  # 7 days × 8 off-peak hours
```

## Indexes

### Recommended Indexes

```sql
-- Index on hierarchy_id for joins
CREATE INDEX idx_hierarchy_id ON da_lmps_ercot(hierarchy_id);

-- Index on date for time-series queries
CREATE INDEX idx_date ON da_lmps_ercot(date);

-- Composite index for common queries
CREATE INDEX idx_hierarchy_date_he ON da_lmps_ercot(hierarchy_id, date, he);

-- Unique constraint for final tables
CREATE UNIQUE INDEX idx_ercot_vlr_unique 
ON ercot_vlr(hierarchy_id, month, he, day_type, hour_type, block_type);
```

## Relationships

### Foreign Key Relationships

```
vlr_hierarchy (id)
    ↓
da_lmps_ercot (hierarchy_id)
rt_lmps_ercot (hierarchy_id)
da_wz_ercot (hierarchy_id)
rt_wz_ercot (hierarchy_id)
    ↓
price_variance_ercot (hierarchy_id)
load_variance_ercot (hierarchy_id)
    ↓
ercot_vlr_hourly_cost (hierarchy_id)
    ↓
ercot_vlr (hierarchy_id)
```

## Data Flow

### VLR Data Flow

```
1. API Data → da_lmps_ercot, rt_lmps_ercot, da_wz_ercot, rt_wz_ercot
2. Calculations → price_variance_ercot, load_variance_ercot
3. Aggregations → ercot_vlr_hourly_cost
4. Final Output → ercot_vlr
```

### Shaping Data Flow

```
1. API Data → da_lmps_ercot
2. Averaging → ercot_shaping_da_lmps_avg
3. Final Calculation → ercot_shaping
```

## Common Queries

### Get Latest Data

```sql
SELECT MAX(date) FROM da_lmps_ercot;
```

### Get Data for Date Range

```sql
SELECT * FROM ercot_vlr
WHERE date BETWEEN '2025-01-01' AND '2025-01-31'
AND hierarchy_id = 1;
```

### Join with Hierarchy

```sql
SELECT 
    h.control_area,
    h.load_zone,
    v.month,
    v.he,
    v.data
FROM ercot_vlr v
JOIN vlr_hierarchy h ON v.hierarchy_id = h.id
WHERE v.month = 1;
```

### Aggregate by Block Type

```sql
SELECT 
    block_type,
    AVG(data) as avg_vlr,
    MIN(data) as min_vlr,
    MAX(data) as max_vlr
FROM ercot_vlr
GROUP BY block_type;
```

## Data Maintenance

### Dropping Tables

SQL scripts are provided for cleanup:

```bash
psql -U user -d database -f ERCOT_VLR/SQL/drop.sql
```

### Resetting Sequences

```bash
psql -U user -d database -f ERCOT_VLR/SQL/drop_sequences.sql
```

### Backup and Restore

```bash
# Backup
pg_dump -U user -d database > backup.sql

# Restore
psql -U user -d database < backup.sql
```

## Performance Considerations

### Partitioning

For large datasets, consider partitioning by date:

```sql
CREATE TABLE da_lmps_ercot_2025 PARTITION OF da_lmps_ercot
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
```

### Vacuum and Analyze

Regular maintenance:

```sql
VACUUM ANALYZE da_lmps_ercot;
```

### Query Optimization

- Use indexes for common queries
- Limit result sets with WHERE clauses
- Use EXPLAIN ANALYZE to optimize queries

## Schema Files Location

All schema SQL files are located in:

- `ERCOT_VLR/SQL/schemas.sql`
- `ERCOT_VLR/SQL/hierarchy.sql`
- `ERCOT_SHAPING/SQL/ERCOT_Shaping.sql`
- Similar paths for other ISOs

## Next Steps

- [Running Instructions](04-running.md) - How to populate the database
- [Troubleshooting](09-troubleshooting.md) - Database-related issues
- [Development Guide](10-development.md) - Adding new tables

---

**Last Updated**: January 2025
