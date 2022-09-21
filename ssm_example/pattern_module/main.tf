# Custom aws provider with parameterized region
provider "aws" {
  region = local.ssm_region
}
# Custom SSM module call
module "my_ssm" {
  source = "../core_module"
}

# Local values to help us reduce code repetition when getting ssm_region
locals {
  ssm_region = var.available_regions[var.region_selector]
}