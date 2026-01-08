-- Drop tables in reverse dependency order to avoid foreign key constraint errors

DROP TABLE IF EXISTS
  public.da_lmps_isone,
  public.rt_lmps_isone,
  public.rt_load_isone,
  public.da_load_isone,
  public.price_variance_isone,
  public.load_variance_isone,
  public.isone_vlr_tot_hedgecostwoimbalance,
  public.isone_vlr_tot_hedgecostwimbalance,
  public.isone_tot_costofimbalance,
  public.isone_vlr_tot_pricewimbalance,
  public.isone_vlr_unitized_cost,
  public.isone_vlr_hourly_cost,
  public.isone_vlr
CASCADE;

DROP TABLE IF EXISTS
  public.da_lmps_isone_hierarchy,
  public.rt_lmps_isone_hierarchy,
  public.rt_load_isone_hierarchy,
  public.da_load_isone_hierarchy,
  public.price_var_isone_hierarchy,
  public.load_var_isone_hierarchy,
  public.isone_vlr_tot_hedgecostwoimbalance_hierarchy,
  public.isone_vlr_tot_hedgecostwimbalance_hierarchy,
  public.isone_tot_costofimbalance_hierarchy,
  public.isone_vlr_tot_pricewimbalance_hierarchy,
  public.isone_vlr_unitized_cost_hierarchy,
  public.isone_vlr_hourly_cost_hierarchy,
  public.isone_vlr_hierarchy
CASCADE;
