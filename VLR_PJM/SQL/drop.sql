-- Drop foreign key constraints first (if CASCADE isn't used later)
-- This step is optional if using CASCADE in DROP TABLE below.

-- Drop main data tables
-- Drop main data tables
DROP TABLE IF EXISTS 
    pjm_vlr_rt_lmps,
    pjm_vlr_da_lmps,
    pjm_vlr_da_load,
    pjm_vlr_rt_load,
    pjm_vlr_price_variance,
    pjm_vlr_price_variance_percentage,
    pjm_vlr_load_variance,
    pjm_vlr_load_variance_percentage,
    pjm_vlr_tot_hedgecostwoimbalance,
    pjm_vlr_tot_costofimbalance,
    pjm_vlr_tot_hedgecostwimbalance,
    pjm_vlr_tot_pricewimbalance,
    pjm_vlr_utilized_cost,
    pjm_vlr_hourly_cost,
    pjm_vlr
CASCADE;

-- Drop hierarchy tables
DROP TABLE IF EXISTS 
    pjm_da_lmps_hierarchy,
    pjm_rt_lmps_hierarchy,
    pjm_rt_load_hierarchy,
    pjm_da_load_hierarchy,
    pjm_price_var_hierarchy,
    pjm_price_var_percentage_hierarchy,
    pjm_load_var_hierarchy,
    pjm_load_var_percentage_hierarchy,
    pjm_tot_hedgecostwoimbalance_hierarchy,
    pjm_tot_hedgecostwimbalance_hierarchy,
    pjm_tot_costofimbalance_hierarchy,
    pjm_tot_pricewimbalance_hierarchy,
    pjm_utilized_cost_hierarchy,
    pjm_hourly_vlr_cost_hierarchy,
    pjm_vlr_hierarchy
CASCADE;
