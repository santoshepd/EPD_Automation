-- Drop foreign key constraints first (if CASCADE isn't used later)
-- This step is optional if using CASCADE in DROP TABLE below.

-- Drop main data tables
DROP TABLE IF EXISTS 
    da_lmps_ercot,
    rt_lmps_ercot,
    da_wz_ercot,
    rt_wz_ercot,
    rt_load_ercot,
    da_load_ercot,
    price_variance_ercot,
    load_variance_ercot,
    ercot_vlr_tot_hedgecostwoimbalance,
    ercot_vlr_tot_hedgecostwimbalance,
    ercot_tot_costofimbalance,
    ercot_vlr_tot_pricewimbalance,
    ercot_vlr_unitized_cost,
    ercot_vlr_hourly_cost,
    ercot_vlr
CASCADE;

-- Drop hierarchy tables
DROP TABLE IF EXISTS 
    da_lmps_ercot_hierarchy,
    rt_lmps_ercot_hierarchy,
    rt_wz_ercot_hierarchy,
    da_wz_ercot_hierarchy,
    rt_load_ercot_hierarchy,
    da_load_ercot_hierarchy,
    price_var_ercot_hierarchy,
    load_var_ercot_hierarchy,
    ercot_vlr_tot_hedgecostwoimbalance_hierarchy,
    ercot_vlr_tot_hedgecostwimbalance_hierarchy,
    ercot_tot_costofimbalance_hierarchy,
    ercot_vlr_tot_pricewimbalance_hierarchy,
    ercot_vlr_unitized_cost_hierarchy,
    ercot_vlr_hourly_cost_hierarchy,
    ercot_vlr_hierarchy
CASCADE;
