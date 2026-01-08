-- Ensure the database exists
-- CREATE DATABASE vlr_miso;

-- Manually switch to `vlr_miso` in your SQL client before running the script

-- Step 1: Create the schema
CREATE SCHEMA IF NOT EXISTS public;
COMMENT ON SCHEMA public IS 'standard public schema';

-- Step 2: Create Hierarchy Tables for miso

-- DA_LMPS_HIERARCHY
CREATE TABLE public.miso_da_lmps_hierarchy (
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

-- RT_LMPS_HIERARCHY
CREATE TABLE public.miso_rt_lmps_hierarchy (
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

-- RT Load Zone Data HIERARCHY
CREATE TABLE public.miso_rt_load_hierarchy (
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

-- DA Load Zone Data HIERARCHY
CREATE TABLE public.miso_da_load_hierarchy (
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

-- Price Variance Percentage HIERARCHY
CREATE TABLE public.miso_price_var_percentage_hierarchy (
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


-- Price Variance HIERARCHY
CREATE TABLE public.miso_price_var_hierarchy (
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
-- Create Table: miso_load_var_percentage_hierarchy
CREATE TABLE public.miso_load_var_percentage_hierarchy (
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





-- Load Variance HIERARCHY
CREATE TABLE public.miso_load_var_hierarchy (
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

-- Total Hedge Cost Without Imbalance HIERARCHY
CREATE TABLE public.miso_tot_hedgecostwoimbalance_hierarchy (
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

-- Total Hedge Cost With Imbalance HIERARCHY
CREATE TABLE public.miso_tot_hedgecostwimbalance_hierarchy (
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

-- Total Cost of Imbalance HIERARCHY
CREATE TABLE public.miso_tot_costofimbalance_hierarchy (
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

-- Total Price With Imbalance HIERARCHY
CREATE TABLE public.miso_tot_pricewimbalance_hierarchy (
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

-- Unitized Cost HIERARCHY
CREATE TABLE public.miso_utilized_cost_hierarchy (
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

-- Hourly VLR Cost HIERARCHY
CREATE TABLE public.miso_hourly_vlr_cost_hierarchy (
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

-- VLR Cost HIERARCHY
CREATE TABLE public.miso_vlr_hierarchy (
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





----Tables----

CREATE TABLE public.miso_vlr_rt_lmps (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    he INTEGER NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_rt_lmps_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.miso_vlr_da_lmps (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    he INTEGER NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_da_lmps_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.miso_vlr_da_load (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    he INTEGER NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_da_load_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.miso_vlr_rt_load (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    he INTEGER NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_rt_load_he_check CHECK (((he >= 1) AND (he <= 24)))
);


CREATE TABLE public.miso_vlr_price_variance (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_price_variance_he_check CHECK (((he >= 1) AND (he <= 24)))
);




CREATE TABLE public.miso_vlr_price_variance_percentage (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_price_variance_percentage_he_check CHECK ((he >= 1 AND he <= 24))
);







CREATE TABLE public.miso_vlr_load_variance (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_load_variance_he_check CHECK (((he >= 1) AND (he <= 24)))
);




CREATE TABLE public.miso_vlr_load_variance_percentage (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_load_variance_percentage_he_check CHECK ((he >= 1 AND he <= 24))
);





CREATE TABLE public.miso_vlr_tot_hedgecostwoimbalance (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_tot_hedgecostwoimbalance_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.miso_vlr_tot_costofimbalance (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_tot_costofimbalance_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.miso_vlr_tot_hedgecostwimbalance (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_tot_hedgecostwimbalance_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.miso_vlr_tot_pricewimbalance (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_tot_pricewimbalance_he_check CHECK (((he >= 1) AND (he <= 24)))
);



CREATE TABLE public.miso_vlr_utilized_cost (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_utilized_cost_he_check CHECK (((he >= 1) AND (he <= 24)))
);







CREATE TABLE public.miso_vlr_hourly_cost (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_hourly_cost_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.miso_vlr (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    day_type CHARACTER VARYING(10) NOT NULL,
    he INTEGER NOT NULL,
    hour_type CHARACTER VARYING(10) NOT NULL,
    block_type CHARACTER VARYING(10) NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT miso_vlr_he_check CHECK (((he >= 1) AND (he <= 24)))
);


------------Alteration---------------- 
-- For miso_vlr_rt_lmps table
CREATE SEQUENCE public.miso_vlr_rt_lmps_id_seq START 1;
ALTER TABLE public.miso_vlr_rt_lmps
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_rt_lmps_id_seq');
-- Optionally, you can set it as PRIMARY KEY if not already
ALTER TABLE public.miso_vlr_rt_lmps ADD PRIMARY KEY (id);

-- For miso_vlr_da_lmps table
CREATE SEQUENCE public.miso_vlr_da_lmps_id_seq START 1;
ALTER TABLE public.miso_vlr_da_lmps
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_da_lmps_id_seq');
ALTER TABLE public.miso_vlr_da_lmps ADD PRIMARY KEY (id);

-- For miso_vlr_da_load table
CREATE SEQUENCE public.miso_vlr_da_load_id_seq START 1;
ALTER TABLE public.miso_vlr_da_load
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_da_load_id_seq');
ALTER TABLE public.miso_vlr_da_load ADD PRIMARY KEY (id);

-- For miso_vlr_rt_load table
CREATE SEQUENCE public.miso_vlr_rt_load_id_seq START 1;
ALTER TABLE public.miso_vlr_rt_load
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_rt_load_id_seq');
ALTER TABLE public.miso_vlr_rt_load ADD PRIMARY KEY (id);

-- For miso_vlr_price_variance table
CREATE SEQUENCE public.miso_vlr_price_variance_id_seq START 1;
ALTER TABLE public.miso_vlr_price_variance
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_price_variance_id_seq');
ALTER TABLE public.miso_vlr_price_variance ADD PRIMARY KEY (id);

-- For miso_vlr_load_variance table
CREATE SEQUENCE public.miso_vlr_load_variance_id_seq START 1;
ALTER TABLE public.miso_vlr_load_variance
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_load_variance_id_seq');
ALTER TABLE public.miso_vlr_load_variance ADD PRIMARY KEY (id);

-- For miso_vlr_tot_hedgecostwoimbalance table
CREATE SEQUENCE public.miso_vlr_tot_hedgecostwoimbalance_id_seq START 1;
ALTER TABLE public.miso_vlr_tot_hedgecostwoimbalance
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_tot_hedgecostwoimbalance_id_seq');
ALTER TABLE public.miso_vlr_tot_hedgecostwoimbalance ADD PRIMARY KEY (id);

-- For miso_vlr_tot_costofimbalance table
CREATE SEQUENCE public.miso_vlr_tot_costofimbalance_id_seq START 1;
ALTER TABLE public.miso_vlr_tot_costofimbalance
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_tot_costofimbalance_id_seq');
ALTER TABLE public.miso_vlr_tot_costofimbalance ADD PRIMARY KEY (id);

-- For miso_vlr_tot_hedgecostwimbalance table
CREATE SEQUENCE public.miso_vlr_tot_hedgecostwimbalance_id_seq START 1;
ALTER TABLE public.miso_vlr_tot_hedgecostwimbalance
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_tot_hedgecostwimbalance_id_seq');
ALTER TABLE public.miso_vlr_tot_hedgecostwimbalance ADD PRIMARY KEY (id);

-- For miso_vlr_tot_pricewimbalance table
CREATE SEQUENCE public.miso_vlr_tot_pricewimbalance_id_seq START 1;
ALTER TABLE public.miso_vlr_tot_pricewimbalance
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_tot_pricewimbalance_id_seq');
ALTER TABLE public.miso_vlr_tot_pricewimbalance ADD PRIMARY KEY (id);

-- For miso_vlr_utilized_cost table
CREATE SEQUENCE public.miso_vlr_utilized_cost_id_seq START 1;
ALTER TABLE public.miso_vlr_utilized_cost
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_utilized_cost_id_seq');
ALTER TABLE public.miso_vlr_utilized_cost ADD PRIMARY KEY (id);

-- For miso_vlr_hourly_cost table
CREATE SEQUENCE public.miso_vlr_hourly_cost_id_seq START 1;
ALTER TABLE public.miso_vlr_hourly_cost
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_hourly_cost_id_seq');
ALTER TABLE public.miso_vlr_hourly_cost ADD PRIMARY KEY (id);

-- For miso_vlr table
CREATE SEQUENCE public.miso_vlr_id_seq START 1;
ALTER TABLE public.miso_vlr
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_id_seq');
ALTER TABLE public.miso_vlr ADD PRIMARY KEY (id);

-- -- Create a sequence for the ID column
CREATE SEQUENCE public.miso_vlr_price_variance_percentage_id_seq START 1;
ALTER TABLE public.miso_vlr_price_variance_percentage
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_price_variance_percentage_id_seq');
ALTER TABLE public.miso_vlr_price_variance_percentage 
    ADD PRIMARY KEY (id);


CREATE SEQUENCE public.miso_vlr_load_variance_percentage_id_seq START 1;

ALTER TABLE public.miso_vlr_load_variance_percentage
    ALTER COLUMN id SET DEFAULT nextval('public.miso_vlr_load_variance_percentage_id_seq');

ALTER TABLE public.miso_vlr_load_variance_percentage 
    ADD PRIMARY KEY (id);



--- ON CONFLICT CONSTRAINTS
-- For miso_vlr_rt_lmps table
ALTER TABLE public.miso_vlr_rt_lmps 
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_rt_lmps UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_da_lmps table
ALTER TABLE public.miso_vlr_da_lmps
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_da_lmps UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_da_load table
ALTER TABLE public.miso_vlr_da_load
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_da_load UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_rt_load table
ALTER TABLE public.miso_vlr_rt_load
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_rt_load UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_price_variance table
ALTER TABLE public.miso_vlr_price_variance
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_price_variance UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_load_variance table
ALTER TABLE public.miso_vlr_load_variance
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_load_variance UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_tot_hedgecostwoimbalance table
ALTER TABLE public.miso_vlr_tot_hedgecostwoimbalance
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_tot_hedgecostwoimbalance UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_tot_costofimbalance table
ALTER TABLE public.miso_vlr_tot_costofimbalance
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_tot_costofimbalance UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_tot_hedgecostwimbalance table
ALTER TABLE public.miso_vlr_tot_hedgecostwimbalance
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_tot_hedgecostwimbalance UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_tot_pricewimbalance table
ALTER TABLE public.miso_vlr_tot_pricewimbalance
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_tot_pricewimbalance UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_utilized_cost table
ALTER TABLE public.miso_vlr_utilized_cost
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_utilized_cost UNIQUE (hierarchy_id, date, he);

-- For miso_vlr_hourly_cost table
ALTER TABLE public.miso_vlr_hourly_cost
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_hourly_cost UNIQUE (hierarchy_id, date, he);

ALTER TABLE public.miso_vlr_load_variance_percentage 
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_load_variance_percentage 
    UNIQUE (hierarchy_id, date, he);

ALTER TABLE public.miso_vlr_price_variance_percentage 
    ADD CONSTRAINT unique_hierarchy_date_he_miso_vlr_price_variance_percentage 
    UNIQUE (hierarchy_id, date, he);




ALTER TABLE miso_vlr
ADD CONSTRAINT miso_vlr_unique UNIQUE (hierarchy_id, date, he, block_type);

---------------------------------------------------------------------------------------------




-- Step 1: Truncate Hierarchy Tables
TRUNCATE TABLE public.miso_da_lmps_hierarchy RESTART IDENTITY CASCADE;
TRUNCATE TABLE public.miso_rt_lmps_hierarchy RESTART IDENTITY CASCADE;
TRUNCATE TABLE public.miso_da_load_hierarchy RESTART IDENTITY CASCADE;
TRUNCATE TABLE public.miso_rt_load_hierarchy RESTART IDENTITY CASCADE;

-- Step 2: Reset Sequences for Value Tables
ALTER SEQUENCE public.miso_vlr_rt_lmps_id_seq RESTART WITH 1;
ALTER SEQUENCE public.miso_vlr_da_lmps_id_seq RESTART WITH 1;
ALTER SEQUENCE public.miso_vlr_da_load_id_seq RESTART WITH 1;
ALTER SEQUENCE public.miso_vlr_rt_load_id_seq RESTART WITH 1;

-- Step 3: Insert Data into Hierarchy Tables


INSERT INTO public.miso_da_lmps_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'LMP', 'Day Ahead LMP', '$/MWh'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'LMP', 'Day Ahead LMP', '$/MWh'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'LMP', 'Day Ahead LMP', '$/MWh');


INSERT INTO public.miso_rt_lmps_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'LMP', 'Real-Time LMP', '$/MWh'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'LMP', 'Real-Time LMP', '$/MWh'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'LMP', 'Real-Time LMP', '$/MWh');



INSERT INTO public.miso_rt_load_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'RT Load', 'RT Load AMIL.CILC.BOC', '$/MWh'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'RT Load', 'RT Load AMIL.CIPS',     '$/MWh'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'RT Load', 'RT Load AMIL.IP',       '$/MWh');


INSERT INTO public.miso_da_load_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'DA Load', 'DA Load AMIL.CILC.BOC', '$/MWh'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'DA Load', 'DA Load AMIL.CIPS',     '$/MWh'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'DA Load', 'DA Load AMIL.IP',       '$/MWh');

-- Price Variance HIERARCHY

INSERT INTO public.miso_price_var_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh');

-- Price Variance % HIERARCHY

INSERT INTO public.miso_price_var_percentage_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'Price Variance (%)', 'Price Variance (%)', '%'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'Price Variance (%)', 'Price Variance (%)', '%'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'Price Variance (%)', 'Price Variance (%)', '%');



-- Load Variance HIERARCHY

INSERT INTO public.miso_load_var_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh');

-- Load Variance  % HIERARCHY


INSERT INTO public.miso_load_var_percentage_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'Load Variance (%)', 'Load Variance (%)', '%'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'Load Variance (%)', 'Load Variance (%)', '%'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'Load Variance (%)', 'Load Variance (%)', '%');

-- tot_hedgecostwoimbalance HIERARCHY
INSERT INTO public.miso_tot_hedgecostwoimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$');


INSERT INTO public.miso_tot_hedgecostwimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$');


INSERT INTO public.miso_tot_costofimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$');




INSERT INTO public.miso_tot_pricewimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$');





INSERT INTO public.miso_utilized_cost_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$');



INSERT INTO public.miso_hourly_vlr_cost_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%');



INSERT INTO public.miso_vlr_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('MISO', 'IL', 'AMIL.CILC.BOC', 'AMIL.CILC.BOC', 'AMEREN', 'HE', 'VLR', 'VLR', '%'),
('MISO', 'IL', 'AMIL.CIPS',     'AMIL.CIPS',     'AMEREN', 'HE', 'VLR', 'VLR', '%'),
('MISO', 'IL', 'AMIL.IP',       'AMIL.IP',       'AMEREN', 'HE', 'VLR', 'VLR', '%');














































	
