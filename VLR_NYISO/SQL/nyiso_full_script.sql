-- DA_LMPS_HIERARCHY
CREATE TABLE public.nyiso_da_lmps_hierarchy (
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
CREATE TABLE public.nyiso_rt_lmps_hierarchy (
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
CREATE TABLE public.nyiso_rt_load_hierarchy (
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
CREATE TABLE public.nyiso_da_load_hierarchy (
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
CREATE TABLE public.nyiso_price_var_percentage_hierarchy (
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
CREATE TABLE public.nyiso_price_var_hierarchy (
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
-- Create Table: nyiso_load_var_percentage_hierarchy
CREATE TABLE public.nyiso_load_var_percentage_hierarchy (
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
CREATE TABLE public.nyiso_load_var_hierarchy (
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
CREATE TABLE public.nyiso_tot_hedgecostwoimbalance_hierarchy (
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
CREATE TABLE public.nyiso_tot_hedgecostwimbalance_hierarchy (
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
CREATE TABLE public.nyiso_tot_costofimbalance_hierarchy (
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
CREATE TABLE public.nyiso_tot_pricewimbalance_hierarchy (
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
CREATE TABLE public.nyiso_utilized_cost_hierarchy (
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
CREATE TABLE public.nyiso_hourly_vlr_cost_hierarchy (
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
CREATE TABLE public.nyiso_vlr_hierarchy (
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

CREATE TABLE public.nyiso_vlr_rt_lmps (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    he INTEGER NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT nyiso_vlr_rt_lmps_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.nyiso_vlr_da_lmps (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    he INTEGER NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT nyiso_vlr_da_lmps_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.nyiso_vlr_da_load (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    he INTEGER NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT nyiso_vlr_da_load_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.nyiso_vlr_rt_load (
    id INTEGER NOT NULL,
    hierarchy_id INTEGER NOT NULL,
    date DATE NOT NULL,
    he INTEGER NOT NULL,
    data NUMERIC(15,5) NOT NULL,
    CONSTRAINT nyiso_vlr_rt_load_he_check CHECK (((he >= 1) AND (he <= 24)))
);


CREATE TABLE public.nyiso_vlr_price_variance (
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
    CONSTRAINT nyiso_vlr_price_variance_he_check CHECK (((he >= 1) AND (he <= 24)))
);


CREATE TABLE public.nyiso_vlr_price_variance_percentage (
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
    CONSTRAINT nyiso_vlr_price_variance_percentage_he_check CHECK ((he >= 1 AND he <= 24))
);



CREATE TABLE public.nyiso_vlr_load_variance (
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
    CONSTRAINT nyiso_vlr_load_variance_he_check CHECK (((he >= 1) AND (he <= 24)))
);


CREATE TABLE public.nyiso_vlr_load_variance_percentage (
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
    CONSTRAINT nyiso_vlr_load_variance_percentage_he_check CHECK ((he >= 1 AND he <= 24))
);





CREATE TABLE public.nyiso_vlr_tot_hedgecostwoimbalance (
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
    CONSTRAINT nyiso_vlr_tot_hedgecostwoimbalance_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.nyiso_vlr_tot_costofimbalance (
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
    CONSTRAINT nyiso_vlr_tot_costofimbalance_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.nyiso_vlr_tot_hedgecostwimbalance (
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
    CONSTRAINT nyiso_vlr_tot_hedgecostwimbalance_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.nyiso_vlr_tot_pricewimbalance (
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
    CONSTRAINT nyiso_vlr_tot_pricewimbalance_he_check CHECK (((he >= 1) AND (he <= 24)))
);



CREATE TABLE public.nyiso_vlr_utilized_cost (
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
    CONSTRAINT nyiso_vlr_utilized_cost_he_check CHECK (((he >= 1) AND (he <= 24)))
);







CREATE TABLE public.nyiso_vlr_hourly_cost (
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
    CONSTRAINT nyiso_vlr_hourly_cost_he_check CHECK (((he >= 1) AND (he <= 24)))
);

CREATE TABLE public.nyiso_vlr (
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
    CONSTRAINT nyiso_vlr_he_check CHECK (((he >= 1) AND (he <= 24)))
);


------------Alteration---------------- 
-- For nyiso_vlr_rt_lmps table
CREATE SEQUENCE public.nyiso_vlr_rt_lmps_id_seq START 1;
ALTER TABLE public.nyiso_vlr_rt_lmps
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_rt_lmps_id_seq');
-- Optionally, you can set it as PRIMARY KEY if not already
ALTER TABLE public.nyiso_vlr_rt_lmps ADD PRIMARY KEY (id);

-- For nyiso_vlr_da_lmps table
CREATE SEQUENCE public.nyiso_vlr_da_lmps_id_seq START 1;
ALTER TABLE public.nyiso_vlr_da_lmps
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_da_lmps_id_seq');
ALTER TABLE public.nyiso_vlr_da_lmps ADD PRIMARY KEY (id);

-- For nyiso_vlr_da_load table
CREATE SEQUENCE public.nyiso_vlr_da_load_id_seq START 1;
ALTER TABLE public.nyiso_vlr_da_load
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_da_load_id_seq');
ALTER TABLE public.nyiso_vlr_da_load ADD PRIMARY KEY (id);

-- For nyiso_vlr_rt_load table
CREATE SEQUENCE public.nyiso_vlr_rt_load_id_seq START 1;
ALTER TABLE public.nyiso_vlr_rt_load
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_rt_load_id_seq');
ALTER TABLE public.nyiso_vlr_rt_load ADD PRIMARY KEY (id);

-- For nyiso_vlr_price_variance table
CREATE SEQUENCE public.nyiso_vlr_price_variance_id_seq START 1;
ALTER TABLE public.nyiso_vlr_price_variance
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_price_variance_id_seq');
ALTER TABLE public.nyiso_vlr_price_variance ADD PRIMARY KEY (id);

-- For nyiso_vlr_load_variance table
CREATE SEQUENCE public.nyiso_vlr_load_variance_id_seq START 1;
ALTER TABLE public.nyiso_vlr_load_variance
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_load_variance_id_seq');
ALTER TABLE public.nyiso_vlr_load_variance ADD PRIMARY KEY (id);

-- For nyiso_vlr_tot_hedgecostwoimbalance table
CREATE SEQUENCE public.nyiso_vlr_tot_hedgecostwoimbalance_id_seq START 1;
ALTER TABLE public.nyiso_vlr_tot_hedgecostwoimbalance
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_tot_hedgecostwoimbalance_id_seq');
ALTER TABLE public.nyiso_vlr_tot_hedgecostwoimbalance ADD PRIMARY KEY (id);

-- For nyiso_vlr_tot_costofimbalance table
CREATE SEQUENCE public.nyiso_vlr_tot_costofimbalance_id_seq START 1;
ALTER TABLE public.nyiso_vlr_tot_costofimbalance
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_tot_costofimbalance_id_seq');
ALTER TABLE public.nyiso_vlr_tot_costofimbalance ADD PRIMARY KEY (id);

-- For nyiso_vlr_tot_hedgecostwimbalance table
CREATE SEQUENCE public.nyiso_vlr_tot_hedgecostwimbalance_id_seq START 1;
ALTER TABLE public.nyiso_vlr_tot_hedgecostwimbalance
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_tot_hedgecostwimbalance_id_seq');
ALTER TABLE public.nyiso_vlr_tot_hedgecostwimbalance ADD PRIMARY KEY (id);

-- For nyiso_vlr_tot_pricewimbalance table
CREATE SEQUENCE public.nyiso_vlr_tot_pricewimbalance_id_seq START 1;
ALTER TABLE public.nyiso_vlr_tot_pricewimbalance
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_tot_pricewimbalance_id_seq');
ALTER TABLE public.nyiso_vlr_tot_pricewimbalance ADD PRIMARY KEY (id);

-- For nyiso_vlr_utilized_cost table
CREATE SEQUENCE public.nyiso_vlr_utilized_cost_id_seq START 1;
ALTER TABLE public.nyiso_vlr_utilized_cost
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_utilized_cost_id_seq');
ALTER TABLE public.nyiso_vlr_utilized_cost ADD PRIMARY KEY (id);

-- For nyiso_vlr_hourly_cost table
CREATE SEQUENCE public.nyiso_vlr_hourly_cost_id_seq START 1;
ALTER TABLE public.nyiso_vlr_hourly_cost
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_hourly_cost_id_seq');
ALTER TABLE public.nyiso_vlr_hourly_cost ADD PRIMARY KEY (id);

-- For nyiso_vlr table
CREATE SEQUENCE public.nyiso_vlr_id_seq START 1;
ALTER TABLE public.nyiso_vlr
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_id_seq');
ALTER TABLE public.nyiso_vlr ADD PRIMARY KEY (id);

-- -- Create a sequence for the ID column
CREATE SEQUENCE public.nyiso_vlr_price_variance_percentage_id_seq START 1;
ALTER TABLE public.nyiso_vlr_price_variance_percentage
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_price_variance_percentage_id_seq');
ALTER TABLE public.nyiso_vlr_price_variance_percentage 
    ADD PRIMARY KEY (id);


CREATE SEQUENCE public.nyiso_vlr_load_variance_percentage_id_seq START 1;

ALTER TABLE public.nyiso_vlr_load_variance_percentage
    ALTER COLUMN id SET DEFAULT nextval('public.nyiso_vlr_load_variance_percentage_id_seq');

ALTER TABLE public.nyiso_vlr_load_variance_percentage 
    ADD PRIMARY KEY (id);



--- ON CONFLICT CONSTRAINTS
-- For nyiso_vlr_rt_lmps table
ALTER TABLE public.nyiso_vlr_rt_lmps 
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_rt_lmps UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_da_lmps table
ALTER TABLE public.nyiso_vlr_da_lmps
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_da_lmps UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_da_load table
ALTER TABLE public.nyiso_vlr_da_load
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_da_load UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_rt_load table
ALTER TABLE public.nyiso_vlr_rt_load
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_rt_load UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_price_variance table
ALTER TABLE public.nyiso_vlr_price_variance
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_price_variance UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_load_variance table
ALTER TABLE public.nyiso_vlr_load_variance
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_load_variance UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_tot_hedgecostwoimbalance table
ALTER TABLE public.nyiso_vlr_tot_hedgecostwoimbalance
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_tot_hedgecostwoimbalance UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_tot_costofimbalance table
ALTER TABLE public.nyiso_vlr_tot_costofimbalance
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_tot_costofimbalance UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_tot_hedgecostwimbalance table
ALTER TABLE public.nyiso_vlr_tot_hedgecostwimbalance
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_tot_hedgecostwimbalance UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_tot_pricewimbalance table
ALTER TABLE public.nyiso_vlr_tot_pricewimbalance
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_tot_pricewimbalance UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_utilized_cost table
ALTER TABLE public.nyiso_vlr_utilized_cost
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_utilized_cost UNIQUE (hierarchy_id, date, he);

-- For nyiso_vlr_hourly_cost table
ALTER TABLE public.nyiso_vlr_hourly_cost
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_hourly_cost UNIQUE (hierarchy_id, date, he);

ALTER TABLE public.nyiso_vlr_load_variance_percentage 
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_load_variance_percentage 
    UNIQUE (hierarchy_id, date, he);

ALTER TABLE public.nyiso_vlr_price_variance_percentage 
    ADD CONSTRAINT unique_hierarchy_date_he_nyiso_vlr_price_variance_percentage 
    UNIQUE (hierarchy_id, date, he);




ALTER TABLE nyiso_vlr
ADD CONSTRAINT nyiso_vlr_unique UNIQUE (hierarchy_id, date, he, block_type);

	
---------FK---------------------------
	






ALTER TABLE public.nyiso_vlr_rt_lmps
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_rt_lmps
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_rt_lmps_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_da_lmps
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_da_lmps
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_da_lmps_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_da_load
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_da_load
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_da_load_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_rt_load
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_rt_load
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_rt_load_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_price_variance
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_price_variance
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_price_var_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_price_variance_percentage
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_price_variance_percentage
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_price_var_percentage_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_load_variance
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_load_variance
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_load_var_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_load_variance_percentage
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_load_variance_percentage
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_load_var_percentage_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_tot_hedgecostwoimbalance
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_tot_hedgecostwoimbalance
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_tot_hedgecostwoimbalance_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_tot_costofimbalance
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_tot_costofimbalance
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_tot_costofimbalance_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_tot_hedgecostwimbalance
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_tot_hedgecostwimbalance
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_tot_hedgecostwimbalance_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_tot_pricewimbalance
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_tot_pricewimbalance
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_tot_pricewimbalance_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_utilized_cost
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_utilized_cost
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_utilized_cost_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr_hourly_cost
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr_hourly_cost
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_hourly_vlr_cost_hierarchy(id)
ON DELETE CASCADE;

ALTER TABLE public.nyiso_vlr
ADD CONSTRAINT fk_hierarchy_id_nyiso_vlr
FOREIGN KEY (hierarchy_id)
REFERENCES public.nyiso_vlr_hierarchy(id)
ON DELETE CASCADE;
