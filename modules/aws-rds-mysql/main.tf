resource "aws_db_instance" "mysql" {
  instance_class             = "${var.db_instance_type}"
  storage_type               = "gp2"
  storage_encrypted          = "true"
  allocated_storage          = "${var.db_storage_size}"
  engine                     = "MySQL"
  engine_version             = "5.7.22"
  identifier                 = "${var.db_identifier}"
  name                       = "${lower(var.db_name)}"
  username                   = "admin"
  password                   = "admin123"
  port                       = "${var.db_port}"
  publicly_accessible        = false
  multi_az                   = "${var.multiaz}"
  parameter_group_name       = "${aws_db_parameter_group.mysql_db_pg.name}"
  db_subnet_group_name       = "${aws_db_subnet_group.db_subnet_group.name}"
  vpc_security_group_ids     = ["${aws_security_group.db_security_group.id}"]
  skip_final_snapshot        = true
 timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}

resource "aws_security_group" "db_security_group" {
  name        = "${var.db_name}-${var.environment}-db-sg"
  description = "Allows access to db"
  vpc_id      = "${var.vpc_id}"
 
  tags = {
      Name = "${var.project}_data_sg"
    }
}


resource "aws_security_group_rule" "allow_db_port" {
  type                     = "ingress"
  from_port                = "${var.db_port}"
  to_port                  = "${var.db_port}"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.vpc_cidr_blocks}"]
  security_group_id        = "${aws_security_group.db_security_group.id}"
}

resource "aws_security_group_rule" "data_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.db_security_group.id}"
}

resource "aws_db_parameter_group" "mysql_db_pg" {
  name   = "db-pgroup-${var.environment}-${var.project}"
  family = "mysql5.7"

  tags = {
      Name = "db_para_group_${var.project}"
    }

}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "db_sg_${var.environment}_${var.project}"
  subnet_ids  = "${var.db_subnet_ids}"

  tags = {
      Name = "db_sub_data_group_${var.project}"
    }

}


#******* Variables ********************
variable db_instance_type {}
variable db_storage_size {}
variable db_name {}
variable db_port {}
variable db_subnet_ids {}
variable project {}
variable multiaz {}
variable environment {}
variable vpc_id {}
variable db_identifier {}
variable vpc_cidr_blocks {}
#******* Outputs ****************
output "db_address" {
  value = "${aws_db_instance.mysql.address}"
}

output "db_endpoint" {
  value = "${aws_db_instance.mysql.endpoint}"
}

output "db_user" {
  value = "${aws_db_instance.mysql.username}"
}
