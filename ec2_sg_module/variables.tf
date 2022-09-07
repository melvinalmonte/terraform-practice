variable "ec2_user_data" {
  type        = string
  description = "Path to user data script"
}

variable "ec2_ami_name" {
  type        = string
  description = "AWS AMI name"
}

variable "ec2_instance_type" {
  type        = string
  description = "AWS AMI Instance type"
}
