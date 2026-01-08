---- DA_LMPS Table Creation for ERCOT VLR

CREATE TABLE public.da_lmps_ercot (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- RT_LMPS Table Creation for ERCOT VLR

CREATE TABLE public.rt_lmps_ercot (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- RT_LMPS Table Creation for ERCOT VLR

CREATE TABLE public.da_wz_ercot (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- RT_LMPS Table Creation for ERCOT VLR

CREATE TABLE public.rt_wz_ercot (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- RT_LOAD Table Creation for ercot VLR

CREATE TABLE public.rt_load_ercot(
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    data NUMERIC(12, 5) NOT NULL           -- Data
);
---- DA_LOAD Table Creation for ercot VLR

CREATE TABLE public.da_load_ercot (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- ercot Price Variance VLR Table
CREATE TABLE public.price_variance_ercot (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    year INT NOT NULL,                     -- Extracted Year
    month INT NOT NULL,                    -- Extracted Month
    day INT NOT NULL,                      -- Extracted Day
    day_type VARCHAR(10) NOT NULL,         -- Weekday or Weekend
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    hour_type VARCHAR(10) NOT NULL,        -- OnPeak / OffPeak
    block_type VARCHAR(10) NOT NULL,       -- 5x16, 2x16, 7x8, etc.
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- ercot Load Variance VLR Table
CREATE TABLE public.load_variance_ercot (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    year INT NOT NULL,                     -- Extracted Year
    month INT NOT NULL,                    -- Extracted Month
    day INT NOT NULL,                      -- Extracted Day
    day_type VARCHAR(10) NOT NULL,         -- Weekday or Weekend
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    hour_type VARCHAR(10) NOT NULL,        -- OnPeak / OffPeak
    block_type VARCHAR(10) NOT NULL,       -- 5x16, 2x16, 7x8, etc.
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- ercot Total Hedgecost WO Imbalance VLR Table
CREATE TABLE public.ercot_vlr_tot_hedgecostwoimbalance (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    year INT NOT NULL,                     -- Extracted Year
    month INT NOT NULL,                    -- Extracted Month
    day INT NOT NULL,                      -- Extracted Day
    day_type VARCHAR(10) NOT NULL,         -- Weekday or Weekend
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    hour_type VARCHAR(10) NOT NULL,        -- OnPeak / OffPeak
    block_type VARCHAR(10) NOT NULL,       -- 5x16, 2x16, 7x8, etc.
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- ercot Total Hedgecost W Imbalance VLR Table
CREATE TABLE public.ercot_vlr_tot_hedgecostwimbalance (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    year INT NOT NULL,                     -- Extracted Year
    month INT NOT NULL,                    -- Extracted Month
    day INT NOT NULL,                      -- Extracted Day
    day_type VARCHAR(10) NOT NULL,         -- Weekday or Weekend
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    hour_type VARCHAR(10) NOT NULL,        -- OnPeak / OffPeak
    block_type VARCHAR(10) NOT NULL,       -- 5x16, 2x16, 7x8, etc.
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- ercot Total Cost of Imbalance VLR Table
CREATE TABLE public.ercot_tot_costofimbalance (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    year INT NOT NULL,                     -- Extracted Year
    month INT NOT NULL,                    -- Extracted Month
    day INT NOT NULL,                      -- Extracted Day
    day_type VARCHAR(10) NOT NULL,         -- Weekday or Weekend
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    hour_type VARCHAR(10) NOT NULL,        -- OnPeak / OffPeak
    block_type VARCHAR(10) NOT NULL,       -- 5x16, 2x16, 7x8, etc.
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- ercot Total Price with Imbalance VLR Table
CREATE TABLE public.ercot_vlr_tot_pricewimbalance (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    year INT NOT NULL,                     -- Extracted Year
    month INT NOT NULL,                    -- Extracted Month
    day INT NOT NULL,                      -- Extracted Day
    day_type VARCHAR(10) NOT NULL,         -- Weekday or Weekend
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    hour_type VARCHAR(10) NOT NULL,        -- OnPeak / OffPeak
    block_type VARCHAR(10) NOT NULL,       -- 5x16, 2x16, 7x8, etc.
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- ercot Unitized Cost VLR Table
CREATE TABLE public.ercot_vlr_unitized_cost (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    year INT NOT NULL,                     -- Extracted Year
    month INT NOT NULL,                    -- Extracted Month
    day INT NOT NULL,                      -- Extracted Day
    day_type VARCHAR(10) NOT NULL,         -- Weekday or Weekend
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    hour_type VARCHAR(10) NOT NULL,        -- OnPeak / OffPeak
    block_type VARCHAR(10) NOT NULL,       -- 5x16, 2x16, 7x8, etc.
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- ercot Hourly Cost VLR Table
CREATE TABLE public.ercot_vlr_hourly_cost (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    year INT NOT NULL,                     -- Extracted Year
    month INT NOT NULL,                    -- Extracted Month
    day INT NOT NULL,                      -- Extracted Day
    day_type VARCHAR(10) NOT NULL,         -- Weekday or Weekend
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    hour_type VARCHAR(10) NOT NULL,        -- OnPeak / OffPeak
    block_type VARCHAR(10) NOT NULL,       -- 5x16, 2x16, 7x8, etc.
    data NUMERIC(12, 5) NOT NULL           -- Data
);

---- ercot VLR Cost Table
CREATE TABLE public.ercot_vlr (
    id SERIAL PRIMARY KEY,               -- Auto-incrementing unique ID
    hierarchy_id INT NOT NULL,            -- Foreign key reference (if applicable)
    date DATE NOT NULL,                   -- The actual date
    year INT NOT NULL,                     -- Extracted Year
    month INT NOT NULL,                    -- Extracted Month
    day INT NOT NULL,                      -- Extracted Day
    day_type VARCHAR(10) NOT NULL,         -- Weekday or Weekend
    he INT NOT NULL CHECK (he BETWEEN 1 AND 24), -- Hour Ending (1-24)
    hour_type VARCHAR(10) NOT NULL,        -- OnPeak / OffPeak
    block_type VARCHAR(10) NOT NULL,       -- 5x16, 2x16, 7x8, etc.
    data NUMERIC(12, 5) NOT NULL           -- Data
);



---- ercot DA_LMPS VLR Hierarchy Table

CREATE TABLE public.da_lmps_ercot_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot RT_LMPS VLR Hierarchy Table

CREATE TABLE public.rt_lmps_ercot_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

CREATE TABLE public.rt_wz_ercot_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

CREATE TABLE public.da_wz_ercot_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot RT_LOAD VLR Hierarchy Table
CREATE TABLE public.rt_load_ercot_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot DA_LOAD VLR Hierarchy Table
CREATE TABLE public.da_load_ercot_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot Price Variance VLR Hierarchy Table
CREATE TABLE public.price_var_ercot_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot Load Variance VLR Hierarchy Table
CREATE TABLE public.load_var_ercot_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot Total Hedge cost without imbalance VLR Hierarchy Table
CREATE TABLE public.ercot_vlr_tot_hedgecostwoimbalance_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot Total Hedge cost with imbalance VLR Hierarchy Table
CREATE TABLE public.ercot_vlr_tot_hedgecostwimbalance_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot Total cost of imbalance VLR Hierarchy Table
CREATE TABLE public.ercot_tot_costofimbalance_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot Total Price with imbalance VLR Hierarchy Table
CREATE TABLE public.ercot_vlr_tot_pricewimbalance_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot Unitized Cost VLR Hierarchy Table
CREATE TABLE public.ercot_vlr_unitized_cost_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot Hourly Cost VLR Hierarchy Table
CREATE TABLE public.ercot_vlr_hourly_cost_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);

---- ercot VLR Cost Hierarchy Table
CREATE TABLE public.ercot_vlr_hierarchy (
    id SERIAL PRIMARY KEY, 
    control_area VARCHAR(50) NOT NULL, 
    state VARCHAR(50) NOT NULL, 
    load_zone VARCHAR(50) NOT NULL, 
    capacity_zone VARCHAR(50) NOT NULL, 
    utility VARCHAR(50) NOT NULL, 
    block_type VARCHAR(50) NOT NULL, 
    cost_group VARCHAR(100) NOT NULL, 
    cost_component VARCHAR(100) NOT NULL, 
    uom VARCHAR(20) NOT NULL
);



--- ON CONFLICT CONSTRAINTS
ALTER table rt_lmps_ercot 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_rtlmps UNIQUE (hierarchy_id, date, he);

ALTER table da_lmps_ercot
ADD CONSTRAINT unique_hierarchy_date_he_ercot_dalmps_vlr UNIQUE (hierarchy_id, date, he);

ALTER table da_load_ercot 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_daload UNIQUE (hierarchy_id, date, he);

-- Login into psql and run these:

ALTER TABLE rt_wz_ercot
ADD CONSTRAINT unique_hierarchy_date_he_rtwz
UNIQUE (hierarchy_id, date, he);

ALTER TABLE da_wz_ercot
ADD CONSTRAINT unique_hierarchy_date_he_dawz
UNIQUE (hierarchy_id, date, he);


ALTER table rt_load_ercot 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_rtload UNIQUE (hierarchy_id, date, he);

ALTER table price_variance_ercot 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_pv UNIQUE (hierarchy_id, date, he);

ALTER table load_variance_ercot 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_lv UNIQUE (hierarchy_id, date, he);

ALTER table ercot_vlr_tot_hedgecostwoimbalance 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_thcwoi UNIQUE (hierarchy_id, date, he);

ALTER table ercot_vlr_tot_hedgecostwimbalance 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_thcwi UNIQUE (hierarchy_id, date, he);

ALTER table ercot_vlr_tot_pricewimbalance 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_tpwm UNIQUE (hierarchy_id, date, he);

ALTER table ercot_tot_costofimbalance 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_tcoi UNIQUE (hierarchy_id, date, he);

ALTER table ercot_vlr_unitized_cost 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_uc UNIQUE (hierarchy_id, date, he);

ALTER table ercot_vlr_hourly_cost 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_hc UNIQUE (hierarchy_id, date, he);

ALTER table ercot_vlr 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_vlr UNIQUE (hierarchy_id, date, he);




---- ercot DA_LMPS VLR Hierarchy Table Values
INSERT INTO public.da_lmps_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh');

---- ercot RT_LMPS VLR Hierarchy Table Values
INSERT INTO public.rt_lmps_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'LMP', 'RTM LMP', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'LMP', 'RTM LMP', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'LMP', 'RTM LMP', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'LMP', 'RTM LMP', '$/MWh');

-- RT Weather Zone Data HIERARCHY
INSERT INTO public.rt_wz_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.EAST.WZ', '$/MWh'),
(2, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.NORTHCENTRAL.WZ', '$/MWh'),
(3, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.COAST.WZ', '$/MWh'),
(4, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.SOUTHERN.WZ', '$/MWh'),
(5, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.SOUTHCENTRAL.WZ', '$/MWh'),
(6, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.WEST.WZ', '$/MWh'),
(7, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.NORTH.WZ', '$/MWh'),
(8, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.FARWEST.WZ', '$/MWh');

-- DA Weather Zone Data HIERARCHY
INSERT INTO public.da_wz_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.EAST.WZ', '$/MWh'),
(2, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.NORTHCENTRAL.WZ', '$/MWh'),
(3, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.COAST.WZ', '$/MWh'),
(4, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.SOUTHERN.WZ', '$/MWh'),
(5, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.SOUTHCENTRAL.WZ', '$/MWh'),
(6, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.WEST.WZ', '$/MWh'),
(7, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.NORTH.WZ', '$/MWh'),
(8, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.FARWEST.WZ', '$/MWh');


---- ercot RT_LOAD VLR Hierarchy Table Values
INSERT INTO public.rt_load_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'RT Load', 'RT Load NORTH ZONE', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'RT Load', 'RT Load HOUSTON ZONE', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'RT Load', 'RT Load SOUTH ZONE', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'RT Load', 'RT Load WEST ZONE', '$/MWh');



---- ercot DA_LOAD VLR Hierarchy Table Values
INSERT INTO public.da_load_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'DAM Load', 'DAM Load NORTH ZONE', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'DAM Load', 'DAM Load HOUSTON ZONE', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'DAM Load', 'DAM Load SOUTH ZONE', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'DAM Load', 'DAM Load WEST ZONE', '$/MWh');


---- ercot Price Variance Hierarchy Table Values
INSERT INTO public.price_var_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
(5, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance (%)', '%'),
(6, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance (%)', '%'),
(7, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance (%)', '%'),
(8, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance (%)', '%');



---- ercot Load Variance Hierarchy Table Values
INSERT INTO public.load_var_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
(5, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance (%)', '%'),
(6, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance (%)', '%'),
(7, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance (%)', '%'),
(8, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance (%)', '%');



INSERT INTO public.ercot_vlr_tot_hedgecostwoimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Hedge Cost (without Imbalance)  - $', 'Hedge Cost (without Imbalance) - $', '$'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Hedge Cost (without Imbalance)  - $', 'Hedge Cost (without Imbalance) - $', '$'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Hedge Cost (without Imbalance)  - $', 'Hedge Cost (without Imbalance) - $', '$'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Hedge Cost (without Imbalance)  - $', 'Hedge Cost (without Imbalance) - $', '$');


INSERT INTO public.ercot_tot_costofimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Total Cost Of Imbalance  - $', 'Total Cost Of Imbalance  - $', '$'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Total Cost Of Imbalance  - $', 'Total Cost Of Imbalance  - $', '$'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Total Cost Of Imbalance  - $', 'Total Cost Of Imbalance  - $', '$'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Total Cost Of Imbalance  - $', 'Total Cost Of Imbalance  - $', '$');


INSERT INTO public.ercot_vlr_tot_hedgecostwimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Hedge Cost (with Imbalance)  - $', 'Hedge Cost (with Imbalance) - $', '$'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Hedge Cost (with Imbalance)  - $', 'Hedge Cost (with Imbalance) - $', '$'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Hedge Cost (with Imbalance)  - $', 'Hedge Cost (with Imbalance) - $', '$'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Hedge Cost (with Imbalance)  - $', 'Hedge Cost (with Imbalance) - $', '$');

INSERT INTO public.ercot_vlr_tot_pricewimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Price (with Imbalance)  - $', 'Price (with Imbalance)  - $', '$'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Price (with Imbalance)  - $', 'Price (with Imbalance)  - $', '$'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Price (with Imbalance)  - $', 'Price (with Imbalance)  - $', '$'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Price (with Imbalance)  - $', 'Price (with Imbalance)  - $', '$');


INSERT INTO public.ercot_vlr_unitized_cost_hierarchy(id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Unitized VLR Cost  - $', 'Unitized VLR Cost  - $', '$'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Unitized VLR Cost  - $', 'Unitized VLR Cost  - $', '$'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Unitized VLR Cost  - $', 'Unitized VLR Cost  - $', '$'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Unitized VLR Cost  - $', 'Unitized VLR Cost  - $', '$');


INSERT INTO public.ercot_vlr_hourly_cost_hierarchy(id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%');



INSERT INTO public.ercot_vlr_hierarchy(id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'VLR', 'VLR)', '%'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'VLR', 'VLR', '%'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'VLR', 'VLR', '%'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'VLR', 'VLR', '%');



--- FOREIGN KEY 
ALTER TABLE public.da_lmps_ercot
ADD CONSTRAINT fk_hierarchy_id_vlr_ecot
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_ercot_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.rt_lmps_ercot 
ADD CONSTRAINT fk_hierarchy_id_ecot
FOREIGN KEY (hierarchy_id) 
REFERENCES public.rt_lmps_ercot_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.rt_load_ercot 
ADD CONSTRAINT fk_hierarchy_id_ercot
FOREIGN KEY (hierarchy_id) 
REFERENCES public.rt_load_ercot_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.da_load_ercot 
ADD CONSTRAINT fk_hierarchy_id_ercot
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_load_ercot_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.price_variance_ercot 
ADD CONSTRAINT fk_hierarchy_id_e
FOREIGN KEY (hierarchy_id) 
REFERENCES public.price_var_ercot_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.load_variance_ercot 
ADD CONSTRAINT fk_hierarchy_id_e
FOREIGN KEY (hierarchy_id) 
REFERENCES public.load_var_ercot_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.ercot_vlr_tot_hedgecostwoimbalance 
ADD CONSTRAINT fk_hierarchy_id_e
FOREIGN KEY (hierarchy_id) 
REFERENCES public.ercot_vlr_tot_hedgecostwoimbalance_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.ercot_vlr_tot_hedgecostwimbalance 
ADD CONSTRAINT fk_hierarchy_id_e
FOREIGN KEY (hierarchy_id) 
REFERENCES public.ercot_vlr_tot_hedgecostwimbalance_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.ercot_tot_costofimbalance 
ADD CONSTRAINT fk_hierarchy_id_e
FOREIGN KEY (hierarchy_id) 
REFERENCES public.ercot_tot_costofimbalance_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.ercot_vlr_tot_pricewimbalance 
ADD CONSTRAINT fk_hierarchy_id_e
FOREIGN KEY (hierarchy_id) 
REFERENCES public.ercot_vlr_tot_pricewimbalance_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.ercot_vlr_unitized_cost 
ADD CONSTRAINT fk_hierarchy_id_e
FOREIGN KEY (hierarchy_id) 
REFERENCES public.ercot_vlr_unitized_cost_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.ercot_vlr_hourly_cost 
ADD CONSTRAINT fk_hierarchy_id_e
FOREIGN KEY (hierarchy_id) 
REFERENCES public.ercot_vlr_hourly_cost_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.ercot_vlr 
ADD CONSTRAINT fk_hierarchy_id_e
FOREIGN KEY (hierarchy_id) 
REFERENCES public.ercot_vlr_hierarchy(id) 
ON DELETE CASCADE;
