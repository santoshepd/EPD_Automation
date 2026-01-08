---- DA_LMPS Table Creation for MISO Shaping

CREATE TABLE public.da_lmps_miso_sh (
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

---- MISO DA_LMPS Shaping Hierarchy Table

CREATE TABLE public.da_lmps_miso_sh_hierarchy (
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

---- MISO DA_LMPS Shaping Hierarchy Table Values

INSERT INTO public.da_lmps_miso_sh_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'MISO', 'IL', 'AMILCILCO', 'AMILCILCO', 'AMEREN', 'HE', 'DA LMP', 'DAM LMP', '$/MWh'),
(2, 'MISO', 'IL', 'AMILCIPS', 'AMILCIPS', 'AMEREN', 'HE', 'DA LMP', 'DAM LMP', '$/MWh'),
(3, 'MISO', 'IL', 'AMILIP', 'AMILIP', 'AMEREN', 'HE', 'DA LMP', 'DAM LMP', '$/MWh');


---- MISO DA_LMPS_AVG Shaping Table
CREATE TABLE public.da_lmps_avg_miso (
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

---- MISO DA_LMPS_AVG Shaping Hierarchy Table

CREATE TABLE public.da_lmps_avg_miso_hierarchy (
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

---- MISO DA_LMPS_AVG Shaping Hierarchy Table Values

INSERT INTO public.da_lmps_avg_miso_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'MISO', 'IL', 'AMILCILCO', 'AMILCILCO', 'AMEREN', 'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(2, 'MISO', 'IL', 'AMILCIPS', 'AMILCIPS', 'AMEREN', 'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(3, 'MISO', 'IL', 'AMILIP', 'AMILIP', 'AMEREN', 'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh');



---- MISO Shaping Table
CREATE TABLE public.miso_shaping (
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

---- MISO Shaping Hierarchy Table
CREATE TABLE public.miso_hierarchy (
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

---- MISO Shaping Hierarchy Table Values
INSERT INTO public.miso_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'MISO', 'IL', 'AMILCILCO', 'AMILCILCO', 'AMEREN', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(2, 'MISO', 'IL', 'AMILCIPS', 'AMILCIPS', 'AMEREN', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(3, 'MISO', 'IL', 'AMILIP', 'AMILIP', 'AMEREN', 'HE', 'Shaping Cost', 'Shaping Cost', '%');


--- ON CONFLICT CONSTRAINTS
ALTER table da_lmps_miso_sh
ADD CONSTRAINT unique_hierarchy_date_he_miso_sh UNIQUE (hierarchy_id, date, he);


ALTER table da_lmps_avg_miso
ADD CONSTRAINT unique_hierarchy_date_he_miso_avg UNIQUE (hierarchy_id, date, he);

ALTER table miso_shaping 
ADD CONSTRAINT unique_hierarchy_date_he_miso_avg_shaping UNIQUE (hierarchy_id, date, he, block_type);


--- FOREIGN KEY 
ALTER TABLE public.da_lmps_miso_sh
ADD CONSTRAINT fk_hierarchy_id_sh
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_miso_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.da_lmps_avg_miso 
ADD CONSTRAINT fk_hierarchy_id_msh
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_avg_miso_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.miso_shaping 
ADD CONSTRAINT fk_hierarchy_id_msh
FOREIGN KEY (hierarchy_id) 
REFERENCES public.miso_hierarchy(id) 
ON DELETE CASCADE;
