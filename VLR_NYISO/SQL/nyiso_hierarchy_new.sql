

INSERT INTO public.nyiso_da_lmps_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('NYISO', 'NYISO', 'NORTH',  'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('NYISO', 'NYISO', 'WEST',   'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh');



INSERT INTO public.nyiso_rt_lmps_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('NYISO', 'NYISO', 'NORTH',  'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('NYISO', 'NYISO', 'WEST',   'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh');




INSERT INTO public.nyiso_rt_load_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('NYISO', 'NYISO', 'NORTH',  'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('NYISO', 'NYISO', 'WEST',   'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh');



INSERT INTO public.nyiso_da_load_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh');



INSERT INTO public.nyiso_price_var_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh');








INSERT INTO public.nyiso_price_var_percentage_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%');




INSERT INTO public.nyiso_load_var_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh');



INSERT INTO public.nyiso_load_var_percentage_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%');




INSERT INTO public.nyiso_tot_hedgecostwoimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$');



INSERT INTO public.nyiso_tot_hedgecostwimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$');










INSERT INTO public.nyiso_tot_costofimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$');





INSERT INTO public.nyiso_tot_pricewimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$');







INSERT INTO public.nyiso_utilized_cost_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$');




INSERT INTO public.nyiso_hourly_vlr_cost_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%');





INSERT INTO public.nyiso_vlr_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('NYISO', 'NYISO', 'CAPITL', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('NYISO', 'NYISO', 'CENTRL', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('NYISO', 'NYISO', 'DUNWOD', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('NYISO', 'NYISO', 'GENESE', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('NYISO', 'NYISO', 'HUD VL', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('NYISO', 'NYISO', 'LONGIL', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('NYISO', 'NYISO', 'MHK VL', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('NYISO', 'NYISO', 'MILLWD', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('NYISO', 'NYISO', 'N.Y.C.', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('NYISO', 'NYISO', 'NORTH', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('NYISO', 'NYISO', 'WEST', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%');


