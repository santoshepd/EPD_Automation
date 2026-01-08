---- DA_LMPS Table Creation for NYISO Shaping

CREATE TABLE public.da_lmps_nyiso_sh (
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

---- NYISO DA_LMPS Shaping Hierarchy Table

CREATE TABLE public.da_lmps_nyiso_sh_hierarchy (
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

---- NYISO DA_LMPS Shaping Hierarchy Table Values

INSERT INTO public.da_lmps_nyiso_sh_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'NYISO', 'NY', 'CAPITL', 'ROS', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(2, 'NYISO', 'NY', 'CENTRL', 'ROS', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(3, 'NYISO', 'NY', 'DUNWOOD', 'LHV', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(4, 'NYISO', 'NY', 'GENESE', 'ROS', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(5, 'NYISO', 'NY', 'HUD VL', 'LHV', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(6, 'NYISO', 'NY', 'LONG IL', 'LI', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(7, 'NYISO', 'NY', 'MHK VL', 'ROS', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(8, 'NYISO', 'NY', 'MILLWD', 'LHV', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(9, 'NYISO', 'NY', 'N.Y.C', 'NYC', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(10,'NYISO', 'NY', 'NORTH', 'ROS', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(11,'NYISO', 'NY', 'WEST', 'ROS', 'ALL', 'HE', 'DA LMP', 'DA LMP', '$/MWh');


---- NYISO DA_LMPS_AVG Shaping Table
CREATE TABLE public.da_lmps_avg_nyiso (
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

---- NYISO DA_LMPS_AVG Shaping Hierarchy Table

CREATE TABLE public.da_lmps_avg_nyiso_hierarchy (
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

---- NYISO DA_LMPS_AVG Shaping Hierarchy Table Values

INSERT INTO public.da_lmps_avg_nyiso_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'NYISO', 'NY', 'CAPITL', 'ROS', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh'),
(2, 'NYISO', 'NY', 'CENTRL', 'ROS', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh'),
(3, 'NYISO', 'NY', 'DUNWOOD', 'LHV', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh'),
(4, 'NYISO', 'NY', 'GENESE', 'ROS', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh'),
(5, 'NYISO', 'NY', 'HUD VL', 'LHV', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh'),
(6, 'NYISO', 'NY', 'LONG IL', 'LI', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh'),
(7, 'NYISO', 'NY', 'MHK VL', 'ROS', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh'),
(8, 'NYISO', 'NY', 'MILLWD', 'LHV', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh'),
(9, 'NYISO', 'NY', 'N.Y.C', 'NYC', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh'),
(10,'NYISO', 'NY', 'NORTH', 'ROS', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh'),
(11,'NYISO', 'NY', 'WEST', 'ROS', 'ALL', 'HE', 'DAM LMP Avg', 'DAM LMP Avg', '$/MWh');


---- NYISO Shaping Table
CREATE TABLE public.nyiso_shaping (
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

---- NYISO Shaping Hierarchy Table
CREATE TABLE public.nyiso_hierarchy (
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

---- NYISO Shaping Hierarchy Table Values
INSERT INTO public.nyiso_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'NYISO', 'NY', 'CAPITL', 'ROS', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(2, 'NYISO', 'NY', 'CENTRL', 'ROS', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(3, 'NYISO', 'NY', 'DUNWOOD', 'LHV', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(4, 'NYISO', 'NY', 'GENESE', 'ROS', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(5, 'NYISO', 'NY', 'HUD VL', 'LHV', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(6, 'NYISO', 'NY', 'LONG IL', 'LI', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(7, 'NYISO', 'NY', 'MHK VL', 'ROS', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(8, 'NYISO', 'NY', 'MILLWD', 'LHV', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(9, 'NYISO', 'NY', 'N.Y.C', 'NYC', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(10,'NYISO', 'NY', 'NORTH', 'ROS', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(11,'NYISO', 'NY', 'WEST', 'ROS', 'ALL', 'HE', 'Shaping Cost', 'Shaping Cost', '%');


--- ON CONFLICT CONSTRAINTS
ALTER table da_lmps_nyiso_sh 
ADD CONSTRAINT unique_hierarchy_date_he_nyiso_sh UNIQUE (hierarchy_id, date, he);


ALTER table da_lmps_avg_nyiso 
ADD CONSTRAINT unique_hierarchy_date_he_nyiso_avg UNIQUE (hierarchy_id, date, he);

ALTER table nyiso_shaping 
ADD CONSTRAINT unique_hierarchy_date_he_nyiso_avg_shaping UNIQUE (hierarchy_id, date, he, block_type);


--- FOREIGN KEY 
ALTER TABLE public.da_lmps_nyiso_sh
ADD CONSTRAINT fk_hierarchy_id_sh
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_nyiso_sh_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.da_lmps_avg_nyiso 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_avg_nyiso_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.nyiso_shaping 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.nyiso_hierarchy(id) 
ON DELETE CASCADE;
