module "ssm_param_california" {
  source = "../pattern_module"
  region_selector = "california"
  has_security_group = true
}

module "ssm_param_oregon" {
  source = "../pattern_module"
  region_selector = "oregon"
}