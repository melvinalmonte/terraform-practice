module "ssm_param_california" {
  source = "../multi_region_ssm"
  region_selector = "california"
}

module "ssm_param_oregon" {
  source = "../multi_region_ssm"
  region_selector = "oregon"
}