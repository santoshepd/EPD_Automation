---- DA_LMPS Table Creation for ISONE VLR

CREATE TABLE public.da_lmps_isone (
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

---- RT_LMPS Table Creation for ISONE VLR

CREATE TABLE public.rt_lmps_isone (
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

---- RT_LOAD Table Creation for ISONE VLR

CREATE TABLE public.rt_load_isone (
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

---- DA_LOAD Table Creation for ISONE VLR

CREATE TABLE public.da_load_isone (
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

---- ISONE Price Variance VLR Table
CREATE TABLE public.price_variance_isone (
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

---- ISONE Load Variance VLR Table
CREATE TABLE public.load_variance_isone (
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

---- ISONE Total Hedgecost WO Imbalance VLR Table
CREATE TABLE public.isone_vlr_tot_hedgecostwoimbalance (
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

---- ISONE Total Hedgecost W Imbalance VLR Table
CREATE TABLE public.isone_vlr_tot_hedgecostwimbalance (
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

---- ISONE Total Cost of Imbalance VLR Table
CREATE TABLE public.isone_tot_costofimbalance (
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

---- ISONE Total Price with Imbalance VLR Table
CREATE TABLE public.isone_vlr_tot_pricewimbalance (
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

---- ISONE Unitized Cost VLR Table
CREATE TABLE public.isone_vlr_unitized_cost (
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

---- ISONE Hourly Cost VLR Table
CREATE TABLE public.isone_vlr_hourly_cost (
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

---- ISONE VLR Cost Table
CREATE TABLE public.isone_vlr (
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



---- ISONE DA_LMPS VLR Hierarchy Table

CREATE TABLE public.da_lmps_isone_hierarchy (
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

---- ISONE RT_LMPS VLR Hierarchy Table

CREATE TABLE public.rt_lmps_isone_hierarchy (
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

---- ISONE RT_LOAD VLR Hierarchy Table
CREATE TABLE public.rt_load_isone_hierarchy (
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

---- ISONE DA_LOAD VLR Hierarchy Table
CREATE TABLE public.da_load_isone_hierarchy (
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

---- ISONE Price Variance VLR Hierarchy Table
CREATE TABLE public.price_var_isone_hierarchy (
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

---- ISONE Load Variance VLR Hierarchy Table
CREATE TABLE public.load_var_isone_hierarchy (
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

---- ISONE Total Hedge cost without imbalance VLR Hierarchy Table
CREATE TABLE public.isone_vlr_tot_hedgecostwoimbalance_hierarchy (
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

---- ISONE Total Hedge cost with imbalance VLR Hierarchy Table
CREATE TABLE public.isone_vlr_tot_hedgecostwimbalance_hierarchy (
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

---- ISONE Total cost of imbalance VLR Hierarchy Table
CREATE TABLE public.isone_tot_costofimbalance_hierarchy (
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

---- ISONE Total Price with imbalance VLR Hierarchy Table
CREATE TABLE public.isone_vlr_tot_pricewimbalance_hierarchy (
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

---- ISONE Unitized Cost VLR Hierarchy Table
CREATE TABLE public.isone_vlr_unitized_cost_hierarchy (
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

---- ISONE Hourly Cost VLR Hierarchy Table
CREATE TABLE public.isone_vlr_hourly_cost_hierarchy (
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

---- ISONE VLR Cost Hierarchy Table
CREATE TABLE public.isone_vlr_hierarchy (
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
ALTER table rt_lmps_isone 
ADD CONSTRAINT unique_hierarchy_date_he_isone_rtlmps UNIQUE (hierarchy_id, date, he);

ALTER table da_lmps_isone
ADD CONSTRAINT unique_hierarchy_date_he_isone_dalmps_vlr UNIQUE (hierarchy_id, date, he);

ALTER table da_load_isone 
ADD CONSTRAINT unique_hierarchy_date_he_isone_daload UNIQUE (hierarchy_id, date, he);

ALTER table rt_load_isone 
ADD CONSTRAINT unique_hierarchy_date_he_isone_rtload UNIQUE (hierarchy_id, date, he);

ALTER table price_variance_isone 
ADD CONSTRAINT unique_hierarchy_date_he_isone_pv UNIQUE (hierarchy_id, date, he);

ALTER table load_variance_isone 
ADD CONSTRAINT unique_hierarchy_date_he_isone_lv UNIQUE (hierarchy_id, date, he);

ALTER table isone_vlr_tot_hedgecostwoimbalance 
ADD CONSTRAINT unique_hierarchy_date_he_isone_thcwoi UNIQUE (hierarchy_id, date, he);

ALTER table isone_vlr_tot_hedgecostwimbalance 
ADD CONSTRAINT unique_hierarchy_date_he_isone_thcwi UNIQUE (hierarchy_id, date, he);

ALTER table isone_vlr_tot_pricewimbalance 
ADD CONSTRAINT unique_hierarchy_date_he_isone_tpwm UNIQUE (hierarchy_id, date, he);

ALTER table isone_tot_costofimbalance 
ADD CONSTRAINT unique_hierarchy_date_he_isone_tcoi UNIQUE (hierarchy_id, date, he);

ALTER table isone_vlr_unitized_cost 
ADD CONSTRAINT unique_hierarchy_date_he_isone_uc UNIQUE (hierarchy_id, date, he);

ALTER table isone_vlr_hourly_cost 
ADD CONSTRAINT unique_hierarchy_date_he_isone_hc UNIQUE (hierarchy_id, date, he);

ALTER table isone_vlr 
ADD CONSTRAINT unique_hierarchy_date_he_isone_vlr UNIQUE (hierarchy_id, date, he);




---- ISONE DA_LMPS VLR Hierarchy Table Values
INSERT INTO public.da_lmps_isone_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh');

---- ISONE RT_LMPS VLR Hierarchy Table Values
INSERT INTO public.rt_lmps_isone_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'RT LMP', 'RTM LMP', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'RT LMP', 'RTM LMP', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'RT LMP', 'RTM LMP', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'RT LMP', 'RTM LMP', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'RT LMP', 'RTM LMP', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'RT LMP', 'RTM LMP', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'RT LMP', 'RTM LMP', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'RT LMP', 'RTM LMP', '$/MWh');


---- ISONE RT_LOAD VLR Hierarchy Table Values
INSERT INTO public.rt_load_isone_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'RT Load', 'RT Load', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'RT Load', 'RT Load', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'RT Load', 'RT Load', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'RT Load', 'RT Load', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'RT Load', 'RT Load', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'RT Load', 'RT Load', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'RT Load', 'RT Load', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'RT Load', 'RT Load', '$/MWh');


---- ISONE DA_LOAD VLR Hierarchy Table Values
INSERT INTO public.da_load_isone_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'DA Load', 'DALoad', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'DA Load', 'DALoad', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'DA Load', 'DALoad', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'DA Load', 'DALoad', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'DA Load', 'DALoad', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'DA Load', 'DALoad', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'DA Load', 'DALoad', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'DA Load', 'DALoad', '$/MWh');


---- ISONE Price Variance Hierarchy Table Values
INSERT INTO public.price_var_isone_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Price Variance', 'Price Variance', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Price Variance', 'Price Variance', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Price Variance', 'Price Variance', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Price Variance', 'Price Variance', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Price Variance', 'Price Variance', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Price Variance', 'Price Variance', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Price Variance', 'Price Variance', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Price Variance', 'Price Variance', '$/MWh'),
(9, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Price Variance', 'Price Variance', '%'),
(10, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Price Variance', 'Price Variance', '%'),
(11, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Price Variance', 'Price Variance', '%'),
(12, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Price Variance', 'Price Variance', '%'),
(13, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Price Variance', 'Price Variance', '%'),
(14, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Price Variance', 'Price Variance', '%'),
(15, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Price Variance', 'Price Variance', '%'),
(16, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Price Variance', 'Price Variance', '%');



---- ISONE Load Variance Hierarchy Table Values
INSERT INTO public.load_var_isone_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Load Variance', 'Load Variance', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Load Variance', 'Load Variance', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Load Variance', 'Load Variance', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Load Variance', 'Load Variance', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Load Variance', 'Load Variance', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Load Variance', 'Load Variance', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Load Variance', 'Load Variance', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Load Variance', 'Load Variance', '$/MWh'),
(9, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Load Variance', 'Load Variance', '%'),
(10, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Load Variance', 'Load Variance', '%'),
(11, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Load Variance', 'Load Variance', '%'),
(12, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Load Variance', 'Load Variance', '%'),
(13, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Load Variance', 'Load Variance', '%'),
(14, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Load Variance', 'Load Variance', '%'),
(15, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Load Variance', 'Load Variance', '%'),
(16, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Load Variance', 'Load Variance', '%');



INSERT INTO public.isone_vlr_tot_hedgecostwoimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Total Hedge Cost ( without Imbalance)', 'Total Hedge Cost ( without Imbalance)', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Total Hedge Cost ( without Imbalance)', 'Total Hedge Cost ( without Imbalance)', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Total Hedge Cost ( without Imbalance)', 'Total Hedge Cost ( without Imbalance)', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Total Hedge Cost ( without Imbalance)', 'Total Hedge Cost ( without Imbalance)', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Total Hedge Cost ( without Imbalance)', 'Total Hedge Cost ( without Imbalance)', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Total Hedge Cost ( without Imbalance)', 'Total Hedge Cost ( without Imbalance)', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Total Hedge Cost ( without Imbalance)', 'Total Hedge Cost ( without Imbalance)', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Total Hedge Cost ( without Imbalance)', 'Total Hedge Cost ( without Imbalance)', '$/MWh');


INSERT INTO public.isone_tot_costofimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Total cost of Imbalance', 'Total cost of Imbalance', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Total cost of Imbalance', 'Total cost of Imbalance', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Total cost of Imbalance', 'Total cost of Imbalance', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Total cost of Imbalance', 'Total cost of Imbalance', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Total cost of Imbalance', 'Total cost of Imbalance', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Total cost of Imbalance', 'Total cost of Imbalance', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Total cost of Imbalance', 'Total cost of Imbalance', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Total cost of Imbalance', 'Total cost of Imbalance', '$/MWh');


INSERT INTO public.isone_vlr_tot_hedgecostwimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Total Hedge Cost ( with Imbalance)', 'Total Hedge Cost ( with Imbalance)', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Total Hedge Cost ( with Imbalance)', 'Total Hedge Cost ( with Imbalance)', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Total Hedge Cost ( with Imbalance)', 'Total Hedge Cost ( with Imbalance)', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Total Hedge Cost ( with Imbalance)', 'Total Hedge Cost ( with Imbalance)', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Total Hedge Cost ( with Imbalance)', 'Total Hedge Cost ( with Imbalance)', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Total Hedge Cost ( with Imbalance)', 'Total Hedge Cost ( with Imbalance)', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Total Hedge Cost ( with Imbalance)', 'Total Hedge Cost ( with Imbalance)', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Total Hedge Cost ( with Imbalance)', 'Total Hedge Cost ( with Imbalance)', '$/MWh');

INSERT INTO public.isone_vlr_tot_pricewimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Total Price ( with Imbalance )', 'Total Price ( with Imbalance )', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Total Price ( with Imbalance )', 'Total Price ( with Imbalance )', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Total Price ( with Imbalance )', 'Total Price ( with Imbalance )', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Total Price ( with Imbalance )', 'Total Price ( with Imbalance )', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Total Price ( with Imbalance )', 'Total Price ( with Imbalance )', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Total Price ( with Imbalance )', 'Total Price ( with Imbalance )', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Total Price ( with Imbalance )', 'Total Price ( with Imbalance )', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Total Price ( with Imbalance )', 'Total Price ( with Imbalance )', '$/MWh');


INSERT INTO public.isone_vlr_unitized_cost_hierarchy(id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Unitized VLR Cost', 'Unitized VLR Cost', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Unitized VLR Cost', 'Unitized VLR Cost', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Unitized VLR Cost', 'Unitized VLR Cost', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Unitized VLR Cost', 'Unitized VLR Cost', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Unitized VLR Cost', 'Unitized VLR Cost', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Unitized VLR Cost', 'Unitized VLR Cost', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Unitized VLR Cost', 'Unitized VLR Cost', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Unitized VLR Cost', 'Unitized VLR Cost', '$/MWh');


INSERT INTO public.isone_vlr_hourly_cost_hierarchy(id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Hourly VLR Cost', 'Hourly VLR Cost', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Hourly VLR Cost', 'Hourly VLR Cost', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Hourly VLR Cost', 'Hourly VLR Cost', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Hourly VLR Cost', 'Hourly VLR Cost', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Hourly VLR Cost', 'Hourly VLR Cost', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Hourly VLR Cost', 'Hourly VLR Cost', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Hourly VLR Cost', 'Hourly VLR Cost', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Hourly VLR Cost', 'Hourly VLR Cost', '$/MWh');



INSERT INTO public.isone_vlr_hierarchy(id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'VLR Cost', 'VLR Cost', '%'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'VLR Cost', 'VLR Cost', '%'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'VLR Cost', 'VLR Cost', '%'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'VLR Cost', 'VLR Cost', '%'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'VLR Cost', 'VLR Cost', '%'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'VLR Cost', 'VLR Cost', '%'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'VLR Cost', 'VLR Cost', '%'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'VLR Cost', 'VLR Cost', '%');



--- FOREIGN KEY 
ALTER TABLE public.da_lmps_isone
ADD CONSTRAINT fk_hierarchy_id_vlr
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_isone_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.rt_lmps_isone 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.rt_lmps_isone_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.rt_load_isone 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.rt_load_isone_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.da_lmps_isone 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_isone_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.price_variance_isone 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.price_var_isone_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.load_variance_isone 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.load_var_isone_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.isone_vlr_tot_hedgecostwoimbalance 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.isone_vlr_tot_hedgecostwoimbalance_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.isone_vlr_tot_hedgecostwimbalance 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.isone_vlr_tot_hedgecostwimbalance_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.isone_tot_costofimbalance 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.isone_tot_costofimbalance_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.isone_vlr_tot_pricewimbalance 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.isone_vlr_tot_pricewimbalance_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.isone_vlr_unitized_cost 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.isone_vlr_unitized_cost_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.isone_vlr_hourly_cost 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.isone_vlr_hourly_cost_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.isone_vlr 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.isone_vlr_hierarchy(id) 
ON DELETE CASCADE;
