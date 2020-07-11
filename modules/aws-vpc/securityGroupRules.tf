# Security Groups
#****************

resource "aws_security_group_rule" "allow_app_port" {
  type                     = "ingress"
  from_port                = "${var.app_port}"
  to_port                  = "${var.app_port}"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.sub_private_cidr}"]
 # source_security_group_id = "${aws_security_group.private.id}"
  security_group_id        = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "allow_web_port" {
  type                     = "ingress"
  from_port                = "${var.web_port}"
  to_port                  = "${var.web_port}"
  protocol                 = "tcp"
  cidr_blocks       	   = ["${var.sub_public_cidr}"]
  security_group_id       = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "allow_db_port" {
  type                     = "ingress"
  from_port                = "${var.db_port}"
  to_port                  = "${var.db_port}"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.sub_public_cidr}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}


resource "aws_security_group_rule" "default_ssh_rule" {
  type                     = "ingress"
  from_port                = "22"
  to_port                  = "22"
  protocol                 = "tcp"
  cidr_blocks       	   = ["${var.sub_private_cidr}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "detault_http_rule" {
  type                     = "ingress"
  from_port                = "80"
  to_port                  = "80"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.sub_private_cidr}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}

resource "aws_security_group_rule" "default_https_rule" {
  type                     = "ingress"
  from_port                = "443"
  to_port                  = "443"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.sub_private_cidr}"]
  security_group_id        = "${aws_security_group.private_sg.id}"
}

#*********** Egress *****************

resource "aws_security_group_rule" "default_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.private_sg.id}"
}


#********* Variables **********

#variable project {}

