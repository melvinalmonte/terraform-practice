resource "aws_ssm_parameter" "hello_world" {
  name  = "myParam"
  type  = "String"
  value = "Hello, world"
}