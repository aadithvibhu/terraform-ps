# Security Groups
#****************

resource "aws_security_group_rule" "default_inbound_rule" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.vpc_sg.id}"
}

resource "aws_security_group_rule" "allow_ssh" {

  type                    = "ingress"
  from_port               = "22"
  to_port                 = "22"
  protocol                = "tcp"
  cidr_blocks             = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.vpc_sg.id}"
}

resource "aws_security_group_rule" "allow_db_Port" {

  type                    = "ingress"
  from_port               = "3306"
  to_port                 = "3306"
  protocol                = "tcp"
  cidr_blocks             = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.vpc_sg.id}"
}

resource "aws_security_group_rule" "allow_app_port" {

  type                    = "ingress"
  from_port               = "3000"
  to_port                 = "3000"
  protocol                = "tcp"
  cidr_blocks             = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.vpc_sg.id}"
}

resource "aws_security_group_rule" "allow_http_port" {

  type                    = "ingress"
  from_port               = "80"
  to_port                 = "80"
  protocol                = "tcp"
  cidr_blocks             = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.vpc_sg.id}"
}

#*********** Egress *****************

resource "aws_security_group_rule" "default_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.vpc_sg.id}"
}


#********* Variables **********

#variable project {}

