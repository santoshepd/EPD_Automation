---- DA_LMPS Table Creation for PJM Shaping

CREATE TABLE public.da_lmps_pjm_sh (
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

---- PJM DA_LMPS Shaping Hierarchy Table

CREATE TABLE public.da_lmps_pjm_sh_hierarchy (
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

---- PJM DA_LMPS Shaping Hierarchy Table Values
INSERT INTO public.da_lmps_pjm_sh_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1,  'PJM', 'NJ',    'AECO',    'AECO',    'AECO',    'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(2,  'PJM', 'OH',    'AEP',     'AEP',     'AEP',     'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(3,  'PJM', 'PA',    'APS',     'APS',     'APS',     'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(4,  'PJM', 'OH/PA', 'ATSI',    'ATSI',    'ATSI',    'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(5,  'PJM', 'MD',    'BGE',     'BGE',     'BGE',     'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(6,  'PJM', 'IL',    'COMED',   'COMED',   'COMED',   'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(7,  'PJM', 'OH',    'DAYTON',  'DAYTON',  'DAYTON',  'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(8,  'PJM', 'OH',    'DEOK',    'DEOK',    'DEOK',    'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(9,  'PJM', 'VA',    'DOM',     'DOM',     'DOM',     'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(10, 'PJM', 'DE/MD', 'DPL',     'DPL',     'DPL',     'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(11, 'PJM', 'PA',    'DUQ',     'DUQ',     'DUQ',     'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(12, 'PJM', 'NJ',    'JCPL',    'JCPL',    'JCPL',    'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(13, 'PJM', 'PA',    'METED',   'METED',   'METED',   'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(14, 'PJM', 'PA',    'PECO',    'PECO',    'PECO',    'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(15, 'PJM', 'PA',    'PENELEC', 'PENELEC', 'PENELEC', 'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(16, 'PJM', 'DC/MD', 'PEPCO',   'PEPCO',   'PEPCO',   'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(17, 'PJM', 'PA',    'PPL',     'PPL',     'PPL',     'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(18, 'PJM', 'NJ',    'PSEG',    'PSEG',    'PSEG',    'HE', 'DA LMP', 'DA LMP', '$/MWh'),
(19, 'PJM', 'NJ',    'RECO',    'RECO',    'RECO',    'HE', 'DA LMP', 'DA LMP', '$/MWh');


---- PJM DA_LMPS_AVG Shaping Table
CREATE TABLE public.da_lmps_avg_pjm (
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

---- PJM DA_LMPS_AVG Shaping Hierarchy Table

CREATE TABLE public.da_lmps_avg_pjm_hierarchy (
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

---- PJM DA_LMPS_AVG Shaping Hierarchy Table Values
INSERT INTO public.da_lmps_avg_pjm_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1,  'PJM', 'NJ',    'AECO',    'AECO',    'AECO',    'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(2,  'PJM', 'OH',    'AEP',     'AEP',     'AEP',     'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(3,  'PJM', 'PA',    'APS',     'APS',     'APS',     'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(4,  'PJM', 'OH/PA', 'ATSI',    'ATSI',    'ATSI',    'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(5,  'PJM', 'MD',    'BGE',     'BGE',     'BGE',     'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(6,  'PJM', 'IL',    'COMED',   'COMED',   'COMED',   'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(7,  'PJM', 'OH',    'DAYTON',  'DAYTON',  'DAYTON',  'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(8,  'PJM', 'OH',    'DEOK',    'DEOK',    'DEOK',    'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(9,  'PJM', 'VA',    'DOM',     'DOM',     'DOM',     'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(10, 'PJM', 'DE/MD', 'DPL',     'DPL',     'DPL',     'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(11, 'PJM', 'PA',    'DUQ',     'DUQ',     'DUQ',     'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(12, 'PJM', 'NJ',    'JCPL',    'JCPL',    'JCPL',    'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(13, 'PJM', 'PA',    'METED',   'METED',   'METED',   'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(14, 'PJM', 'PA',    'PECO',    'PECO',    'PECO',    'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(15, 'PJM', 'PA',    'PENELEC', 'PENELEC', 'PENELEC', 'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(16, 'PJM', 'DC/MD', 'PEPCO',   'PEPCO',   'PEPCO',   'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(17, 'PJM', 'PA',    'PPL',     'PPL',     'PPL',     'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(18, 'PJM', 'NJ',    'PSEG',    'PSEG',    'PSEG',    'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh'),
(19, 'PJM', 'NJ',    'RECO',    'RECO',    'RECO',    'HE', 'DA LMP', 'DAM LMP AVG', '$/MWh');



---- PJM Shaping Table
CREATE TABLE public.pjm_shaping (
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

---- PJM Shaping Hierarchy Table
CREATE TABLE public.pjm_hierarchy (
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

---- PJM Shaping Hierarchy Table Values
INSERT INTO public.pjm_hierarchy (
    id, control_area, state, load_zone, capacity_zone, utility, 
    block_type, cost_group, cost_component, uom
) 
VALUES
(1,  'PJM', 'NJ',    'AECO',    'AECO',    'AECO',    'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(2,  'PJM', 'OH',    'AEP',     'AEP',     'AEP',     'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(3,  'PJM', 'PA',    'APS',     'APS',     'APS',     'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(4,  'PJM', 'OH/PA', 'ATSI',    'ATSI',    'ATSI',    'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(5,  'PJM', 'MD',    'BGE',     'BGE',     'BGE',     'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(6,  'PJM', 'IL',    'COMED',   'COMED',   'COMED',   'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(7,  'PJM', 'OH',    'DAYTON',  'DAYTON',  'DAYTON',  'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(8,  'PJM', 'OH',    'DEOK',    'DEOK',    'DEOK',    'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(9,  'PJM', 'VA',    'DOM',     'DOM',     'DOM',     'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(10, 'PJM', 'DE/MD', 'DPL',     'DPL',     'DPL',     'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(11, 'PJM', 'PA',    'DUQ',     'DUQ',     'DUQ',     'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(12, 'PJM', 'NJ',    'JCPL',    'JCPL',    'JCPL',    'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(13, 'PJM', 'PA',    'METED',   'METED',   'METED',   'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(14, 'PJM', 'PA',    'PECO',    'PECO',    'PECO',    'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(15, 'PJM', 'PA',    'PENELEC', 'PENELEC', 'PENELEC', 'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(16, 'PJM', 'DC/MD', 'PEPCO',   'PEPCO',   'PEPCO',   'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(17, 'PJM', 'PA',    'PPL',     'PPL',     'PPL',     'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(18, 'PJM', 'NJ',    'PSEG',    'PSEG',    'PSEG',    'HE', 'Shaping Cost', 'Shaping Cost', '%'),
(19, 'PJM', 'NJ',    'RECO',    'RECO',    'RECO',    'HE', 'Shaping Cost', 'Shaping Cost', '%');



--- ON CONFLICT CONSTRAINTS
ALTER table da_lmps_pjm_sh 
ADD CONSTRAINT unique_hierarchy_date_he_pjm_sh UNIQUE (hierarchy_id, date, he);


ALTER table da_lmps_avg_pjm
ADD CONSTRAINT unique_hierarchy_date_he_pjm_avg UNIQUE (hierarchy_id, date, he);

ALTER table pjm_shaping 
ADD CONSTRAINT unique_hierarchy_date_he_pjm_avg_shaping UNIQUE (hierarchy_id, date, he, block_type);


--- FOREIGN KEY 
ALTER TABLE public.da_lmps_pjm_sh
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_pjm_sh_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.da_lmps_avg_pjm 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.da_lmps_avg_pjm_hierarchy(id) 
ON DELETE CASCADE;

ALTER TABLE public.pjm_shaping 
ADD CONSTRAINT fk_hierarchy_id
FOREIGN KEY (hierarchy_id) 
REFERENCES public.pjm_hierarchy(id) 
ON DELETE CASCADE;
