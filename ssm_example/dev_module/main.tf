module "ssm_param_california" {
  source = "../pattern_module"
  region_selector = "california"
}

module "ssm_param_oregon" {
  source = "../pattern_module"
  region_selector = "oregon"
}