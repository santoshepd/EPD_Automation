---- DA_LMPS Table Creation for ERCOT Shaping

CREATE TABLE public.ercot_shaping_da_lmps (
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

---- ERCOT DA_LMPS  Hierarchy Table

CREATE TABLE public.da_lmps_hierarchy (
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

---- ERCOT DA_LMPS Shaping Hierarchy Table Values

INSERT INTO public.da_lmps_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh');


---- ERCOT DA_LMPS_AVG Shaping Table
CREATE TABLE public.ercot_shaping_da_lmps_avg (
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

---- ERCOT DA_LMPS_AVG Shaping Hierarchy Table

CREATE TABLE public.da_lmps_avg_ercot_hierarchy (
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

---- ERCOT DA_LMPS_AVG Shaping Hierarchy Table Values

INSERT INTO public.da_lmps_avg_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP AVG', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP AVG', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP AVG', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP AVG', '$/MWh');


---- ERCOT Shaping Table
CREATE TABLE public.ercot_shaping (
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

---- ERCOT Shaping Hierarchy Table
CREATE TABLE public.ercot_hierarchy (
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

---- ERCOT Shaping Hierarchy Table Values
INSERT INTO public.ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%');


--- ON CONFLICT CONSTRAINTS
ALTER table ercot_shaping_da_lmps 
ADD CONSTRAINT unique_hierarchy_date_he_ercot UNIQUE (hierarchy_id, date, he);


ALTER table ercot_shaping_da_lmps_avg 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_avg UNIQUE (hierarchy_id, date, he);

ALTER table ercot_shaping 
ADD CONSTRAINT unique_hierarchy_date_he_ercot_avg_shaping UNIQUE (hierarchy_id, date, he, block_type);


--- FOREIGN KEY 
ALTER TABLE public.ercot_shaping_da_lmps
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.ercot_shaping_da_lmps_avg 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_avg_ercot_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.ercot_shaping 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.ercot_hierarchy(id) 
ON DELETE CASCADE;
