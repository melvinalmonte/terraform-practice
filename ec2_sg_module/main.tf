provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "my_app_security_group" {
  vpc_id = "vpc-4092303a"
  description = "some description"
  name = "some name"
}

resource "aws_security_group_rule" "my_security_group_rule_ingress" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.my_app_security_group.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "my_security_group_ssh_ingress" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.my_app_security_group.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "my_security_group_rule_egress" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.my_app_security_group.id
  to_port           = 0
  type              = "egress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_instance" "my_ec2" {
#  instance_type = "t2.micro"
  instance_type = var.ec2_instance_type
#  ami = "ami-0ac019f4fcb7cb7e6"
  ami = var.ec2_ami_name
  subnet_id = "subnet-8c65bfb2"
  vpc_security_group_ids = [aws_security_group.my_app_security_group.id]
  key_name = "mytestkey"
#  user_data allows us to pass a shell command
#  user_data = "${file("script1.sh")}"
  user_data = file(var.ec2_user_data)
  user_data_replace_on_change = true

}