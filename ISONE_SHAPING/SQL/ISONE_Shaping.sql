---- DA_LMPS Table Creation for ISONE Shaping

CREATE TABLE public.da_lmps_isone_sh (
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

---- ISONE DA_LMPS Shaping Hierarchy Table

CREATE TABLE public.da_lmps_isone_sh_hierarchy (
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

---- ISONE DA_LMPS Shaping Hierarchy Table Values

INSERT INTO public.da_lmps_isone_sh_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'DA LMP', 'DAM LMP', '$/MWh');




---- ISONE DA_LMPS_AVG Shaping Table
CREATE TABLE public.da_lmps_avg_isone (
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

---- ISONE DA_LMPS_AVG Shaping Hierarchy Table

CREATE TABLE public.da_lmps_avg_isone_hierarchy (
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

---- ISONE DA_LMPS_AVG Shaping Hierarchy Table Values

INSERT INTO public.da_lmps_avg_isone_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'DA LMP', 'DAM LMP AVG', '$/MWh');




---- ISONE Shaping Table
CREATE TABLE public.isone_shaping (
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

---- ISONE Shaping Hierarchy Table
CREATE TABLE public.isone_hierarchy (
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

---- ISONE Shaping Hierarchy Table Values
INSERT INTO public.isone_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ISONE', 'CT', 'CONNECTICUT', 'CONNECTICUT', 'ALL', '7x24', 'Shaping Cost', 'Shaping Cost', '%'),
(2, 'ISONE', 'ME', 'MAINE', 'MAINE', 'ALL', '7x24', 'Shaping Cost', 'Shaping Cost', '%'),
(3, 'ISONE', 'MA', 'NEMASSBOST', 'NEMASSBOST', 'ALL', '7x24', 'Shaping Cost', 'Shaping Cost', '%'),
(4, 'ISONE', 'NH', 'NEW HAMPSHIRE', 'NEW HAMPSHIRE', 'ALL', '7x24', 'Shaping Cost', 'Shaping Cost', '%'),
(5, 'ISONE', 'RI', 'RHODE ISLAND', 'RHODE ISLAND', 'ALL', '7x24', 'Shaping Cost', 'Shaping Cost', '%'),
(6, 'ISONE', 'MA', 'SEMASS', 'SEMASS', 'ALL', '7x24', 'Shaping Cost', 'Shaping Cost', '%'),
(7, 'ISONE', 'VT', 'VERMONT', 'VERMONT', 'ALL', '7x24', 'Shaping Cost', 'Shaping Cost', '%'),
(8, 'ISONE', 'MA', 'WCMASS', 'WCMASS', 'ALL', '7x24', 'Shaping Cost', 'Shaping Cost', '%');


--- ON CONFLICT CONSTRAINTS
ALTER table da_lmps_isone_sh
ADD CONSTRAINT unique_hierarchy_date_he_isone_sh UNIQUE (hierarchy_id, date, he);


ALTER table da_lmps_avg_isone
ADD CONSTRAINT unique_hierarchy_date_he_isone_avg UNIQUE (hierarchy_id, date, he);

ALTER table isone_shaping 
ADD CONSTRAINT unique_hierarchy_date_he_isone_avg_shaping UNIQUE (hierarchy_id, date, he, block_type);


--- FOREIGN KEY 
ALTER TABLE public.da_lmps_isone_sh
ADD CONSTRAINT fk_hierarchy_id_sh
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_isone_sh_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.da_lmps_avg_isone
ADD CONSTRAINT fk_hierarchy_id_sha
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_avg_isone_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.isone_shaping 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.isone_hierarchy(id) 
ON DELETE CASCADE;
