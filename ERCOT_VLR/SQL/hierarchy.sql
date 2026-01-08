
-- DA_LMPS_HIERARCHY
INSERT INTO public.da_lmps_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'LMP', 'DAM LMP', '$/MWh');

-- RT_LMPS_HIERARCHY
INSERT INTO public.rt_lmps_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'LMP', 'RTM LMP', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'LMP', 'RTM LMP', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'LMP', 'RTM LMP', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'LMP', 'RTM LMP', '$/MWh');

-- RT Weather Zone Data HIERARCHY
INSERT INTO public.rt_wz_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.EAST.WZ', '$/MWh'),
(2, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.NORTHCENTRAL.WZ', '$/MWh'),
(3, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.COAST.WZ', '$/MWh'),
(4, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.SOUTHERN.WZ', '$/MWh'),
(5, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.SOUTHCENTRAL.WZ', '$/MWh'),
(6, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.WEST.WZ', '$/MWh'),
(7, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.NORTH.WZ', '$/MWh'),
(8, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'RTM Load', 'RTM Load ERCOT.FARWEST.WZ', '$/MWh');

-- DA Weather Zone Data HIERARCHY
INSERT INTO public.da_wz_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.EAST.WZ', '$/MWh'),
(2, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.NORTHCENTRAL.WZ', '$/MWh'),
(3, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.COAST.WZ', '$/MWh'),
(4, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.SOUTHERN.WZ', '$/MWh'),
(5, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.SOUTHCENTRAL.WZ', '$/MWh'),
(6, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.WEST.WZ', '$/MWh'),
(7, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.NORTH.WZ', '$/MWh'),
(8, 'ERCOT', 'TX', 'ALL', 'ALL', 'ALL', 'HE', 'DAM Load', 'DAM Load ERCOT.FARWEST.WZ', '$/MWh');

-- RT Load Zone Data HIERARCHY
INSERT INTO public.rt_load_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'RT Load', 'RT Load NORTH ZONE', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'RT Load', 'RT Load HOUSTON ZONE', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'RT Load', 'RT Load SOUTH ZONE', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'RT Load', 'RT Load WEST ZONE', '$/MWh');

-- DA Load Zone Data HIERARCHY
INSERT INTO public.da_load_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'DAM Load', 'DAM Load NORTH ZONE', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'DAM Load', 'DAM Load HOUSTON ZONE', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'DAM Load', 'DAM Load SOUTH ZONE', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'DAM Load', 'DAM Load WEST ZONE', '$/MWh');

-- Price Variance HIERARCHY
INSERT INTO public.price_var_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
(5, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance (%)', '%'),
(6, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance (%)', '%'),
(7, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance (%)', '%'),
(8, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Price Variance ($/MWh)', 'Price Variance (%)', '%');

-- Load Variance HIERARCHY
INSERT INTO public.load_var_ercot_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
(5, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance (%)', '%'),
(6, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance (%)', '%'),
(7, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance (%)', '%'),
(8, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Load Variance ($/MWh)', 'Load Variance (%)', '%');


-- Total Hedge Cost Without Imbalance Data HIERARCHY
INSERT INTO public.ercot_vlr_tot_hedgecostwoimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Hedge Cost (without Imbalance)  - $', 'Hedge Cost (without Imbalance) - $', '$'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Hedge Cost (without Imbalance)  - $', 'Hedge Cost (without Imbalance) - $', '$'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Hedge Cost (without Imbalance)  - $', 'Hedge Cost (without Imbalance) - $', '$'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Hedge Cost (without Imbalance)  - $', 'Hedge Cost (without Imbalance) - $', '$');

-- Total Hedge Cost With Imbalance Data HIERARCHY
INSERT INTO public.ercot_vlr_tot_hedgecostwimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Hedge Cost (with Imbalance)  - $', 'Hedge Cost (with Imbalance) - $', '$'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Hedge Cost (with Imbalance)  - $', 'Hedge Cost (with Imbalance) - $', '$'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Hedge Cost (with Imbalance)  - $', 'Hedge Cost (with Imbalance) - $', '$'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Hedge Cost (with Imbalance)  - $', 'Hedge Cost (with Imbalance) - $', '$');

-- Total Cost of Imbalance Data HIERARCHY
INSERT INTO public.ercot_tot_costofimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Total Cost Of Imbalance  - $', 'Total Cost Of Imbalance  - $', '$'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Total Cost Of Imbalance  - $', 'Total Cost Of Imbalance  - $', '$'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Total Cost Of Imbalance  - $', 'Total Cost Of Imbalance  - $', '$'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Total Cost Of Imbalance  - $', 'Total Cost Of Imbalance  - $', '$');

-- Total Price With Imbalance Data HIERARCHY
INSERT INTO public.ercot_vlr_tot_pricewimbalance_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Price (with Imbalance)  - $', 'Price (with Imbalance)  - $', '$'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Price (with Imbalance)  - $', 'Price (with Imbalance)  - $', '$'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Price (with Imbalance)  - $', 'Price (with Imbalance)  - $', '$'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Price (with Imbalance)  - $', 'Price (with Imbalance)  - $', '$');

-- Unitized VLR Cost Data HIERARCHY
INSERT INTO public.ercot_vlr_unitized_cost_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'Unitized VLR Cost  - $', 'Unitized VLR Cost  - $', '$'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'Unitized VLR Cost  - $', 'Unitized VLR Cost  - $', '$'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'Unitized VLR Cost  - $', 'Unitized VLR Cost  - $', '$'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'Unitized VLR Cost  - $', 'Unitized VLR Cost  - $', '$');

-- Hourly VLR Cost Data HIERARCHY
INSERT INTO public.ercot_vlr_hourly_cost_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'VLR Cost(%)', 'VLR Cost(%)', '%');

-- VLR Cost Data HIERARCHY
INSERT INTO public.ercot_vlr_hierarchy (id, control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
(1, 'ERCOT', 'TX', 'NORTH ZONE', 'NORTH ZONE', 'ALL', 'HE', 'VLR', 'VLR)', '%'),
(2, 'ERCOT', 'TX', 'HOUSTON ZONE', 'HOUSTON ZONE', 'ALL', 'HE', 'VLR', 'VLR', '%'),
(3, 'ERCOT', 'TX', 'SOUTH ZONE', 'SOUTH ZONE', 'ALL', 'HE', 'VLR', 'VLR', '%'),
(4, 'ERCOT', 'TX', 'WEST ZONE', 'WEST ZONE', 'ALL', 'HE', 'VLR', 'VLR', '%');

