resource "aws_security_group" "sg_devops" {
  name        = "sg_devops"
  description = "Allow inbound traffic"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name                     = "sg_devops"
    Type                     = "EC2 Security Group"
    Monitoring               = "true"
  }
}
