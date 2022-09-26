# Custom aws provider with parameterized region
provider "aws" {
  region = local.ssm_region
}
# Custom SSM module call
module "my_ssm" {
  source = "../core_ssm_module"
}

# Security group that will be conditionally created, if has_security_group flag is set to true it will create, by default is set to false.
module "my_sg" {
  source = "../core_sg_module"
  count  = var.has_security_group ? 1 : 0
}

# Local values to help us reduce code repetition when getting ssm_region
locals {
  ssm_region = var.available_regions[var.region_selector]
}
