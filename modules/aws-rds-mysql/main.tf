module "vpc" {
  source = "../aws-vpc"
}
resource "aws_db_instance" "mod_rds" {
  instance_class             = "${var.instance_type}"
  storage_type               = "gp2"
  storage_encrypted          = "true"
  allocated_storage          = "${var.storage_size}"
  engine                     = "MySQL"
  name                       = "${lower(var.db_name)}"
  username                   = "db_admin"
  password                   = "dbpassword123"
  port                       = "${var.db_port}"
  publicly_accessible        = false
  multi_az                   = "${var.multiaz}"
  #vpc_id		     = module.vpc.devops.id
  #parameter_group_name       = "{aws_db_parameter_group.db_parameter_group.name}"
  #db_subnet_group_name       = "{aws_db_subnet_group.db_subnet_group}"
  vpc_security_group_ids     = ["${aws_security_group.db_security_group.id}"]

  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "db_subnet_group"
  subnet_ids  = ["module.vpc.data_subnet"]
}
#
#resource "aws_db_parameter_group" "db_parameter_group" {
#  name   = "rds_mysql"
#  family = "${var.engine_family}"
#  
#    parameter {
#    name  = "character_set_server"
#    value = "utf8"
#  }
#}

resource "aws_security_group" "db_security_group" {
  name        = "db_security_group"
  vpc_id      = module.vpc.vpc_id
}
