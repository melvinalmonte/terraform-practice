# All available regions for us to write an SSM param
variable "available_regions" {
  type = map(string)
  default = {
    virginia="us-east-1"
    ohio="us-east-2"
    california="us-west-1"
    oregon="us-west-2"
  }
}

# Parameterized value to help us change regions dynamically with the default region being virginia
# This default value can be overwritten in our terraform.tfvars.json file.
variable "region_selector" {
  type = string
  default = "virginia"
}

# Local values to help us reduce code repetition when getting ssm_region
locals {
  ssm_region = var.available_regions[var.region_selector]
}

# Custom aws provider with parameterized region
provider "aws" {
  region = local.ssm_region
}
# Custom SSM module call
module "my_ssm" {
  source = "../ssm_module"
}