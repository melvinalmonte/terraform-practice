module "custom_ec2_module" {
    source = "../ec2_sg_module"
    ec2_ami_name = ""
    ec2_instance_type = ""
    ec2_user_data = ""
}