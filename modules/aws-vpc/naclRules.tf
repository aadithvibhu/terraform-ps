resource "aws_network_acl" "main_nacl" {
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.default_route}"
    from_port  = 8080
    to_port    = 8080
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.default_route}"
    from_port  = 8080
    to_port    = 8080
  }
  tags = {
    Name = "${var.project}-nacl-rules"
  }
}
#********* Variables **********

#variable project {}
#variable default_route {}

#********** Outputs ************

output "nacl_id" {
  value       = aws_network_acl.main_nacl.id
}
