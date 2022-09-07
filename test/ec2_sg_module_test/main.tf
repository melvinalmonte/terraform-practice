variable "ami_name" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "user_data" {
  type = map(string)
  default = {
    melvin="script1.sh"
    rahul="script2.sh"
  }
}

variable "script_selector" {
  type = string
}

module "ec2_sg_module_test" {
  source = "../../ec2_sg_module"
  ec2_ami_name = var.ami_name
  ec2_instance_type = var.instance_type
  ec2_user_data = var.user_data[var.script_selector]
}

resource "aws_lb" "my_alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.ec2_sg_module_test.ec2_security_group_id]
  subnets            = ["subnet-8c65bfb2", "subnet-2b6ff94c"]
}

resource "aws_lb_target_group" "lb_tg" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-4092303a"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "lb_attachment" {
  target_group_arn = aws_lb_target_group.lb_tg.arn
  target_id        = module.ec2_sg_module_test.ec2_instance_id
  port             = 80
}