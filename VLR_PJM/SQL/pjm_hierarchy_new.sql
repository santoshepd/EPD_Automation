

INSERT INTO public.pjm_da_lmps_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'LMP', 'Day Ahead LMP', '$/MWh');




INSERT INTO public.pjm_rt_lmps_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'LMP', 'RTM LMPS', '$/MWh');





INSERT INTO public.pjm_rt_load_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'RT Load', 'RT Load', '$/MWh');




INSERT INTO public.pjm_da_load_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'DA Load', 'DA Load', '$/MWh');




INSERT INTO public.pjm_price_var_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'Price Variance ($/MWh)', 'Price Variance ($/MWh)', '$/MWh');







INSERT INTO public.pjm_price_var_percentage_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'Price Variance (%)', 'Price Variance (%)', '%');





INSERT INTO public.pjm_load_var_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'Load Variance ($/MWh)', 'Load Variance ($/MWh)', '$/MWh');




INSERT INTO public.pjm_load_var_percentage_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'Load Variance (%)', 'Load Variance (%)', '%');





INSERT INTO public.pjm_tot_hedgecostwoimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'Hedge Cost (without Imbalance) - $', 'Hedge Cost (without Imbalance) - $', '$');


INSERT INTO public.pjm_tot_hedgecostwimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'Hedge Cost (with Imbalance) - $', 'Hedge Cost (with Imbalance) - $', '$');







INSERT INTO public.pjm_tot_costofimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'Total Cost Of Imbalance - $', 'Total Cost Of Imbalance - $', '$');




INSERT INTO public.pjm_tot_pricewimbalance_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'Price (with Imbalance) - $', 'Price (with Imbalance) - $', '$');







INSERT INTO public.pjm_utilized_cost_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'Unitized VLR Cost - $', 'Unitized VLR Cost - $', '$');



INSERT INTO public.pjm_hourly_vlr_cost_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'VLR Cost(%)', 'VLR Cost(%)', '%');



INSERT INTO public.pjm_vlr_hierarchy 
(control_area, state, load_zone, capacity_zone, utility, block_type, cost_group, cost_component, uom) 
VALUES
('PJM', 'PJM', 'AECO', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'AEP', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'APS', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'ATSI', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'BGE', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'COMED', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'DAY', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'DEOK', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'DOM', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'DPL', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'DUQ', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'JCPL', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'METED', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'PECO', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'PENELEC', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'PEPCO', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'PPL', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'PSEG', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%'),
('PJM', 'PJM', 'RECO', 'ALL', 'ALL', '7X24', 'VLR', 'VLR', '%');



