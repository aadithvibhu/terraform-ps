# Security Groups
#****************

resource "aws_security_group" "vpc_sg" {
  name        = "${var.project}_vpc_sg"
  description = "Allow inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"
  tags = {
    Name                     = "${var.project}_vpc_sg"
    Type                     = "EC2 Security Group"
    Monitoring               = "true"
  }
}

#********* Variables **********

#variable project {}

#********** Outputs ************

output "vpc_security" {
  value       = aws_security_group.vpc_sg.id
}
