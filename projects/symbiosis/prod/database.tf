module "symbdb" {
  source = "../../../modules/aws-rds-mysql"
  vpc_id                      = "${data.aws_vpc.main.id}"
  db_instance_type            = "db.t2.small"
  db_name                     = "symbdb"
  db_port                     = "3306"
  db_subnet_ids               = ["${data.aws_subnet.private_subnet_2.id}", "${data.aws_subnet.data_subnet_1.id}"]
  multiaz                     = false
  db_storage_size             = "20"
  project                     = "${var.project}"
  environment                 = "${var.environment}"
  db_identifier               = "symbiosis"
  vpc_cidr_blocks             = "${data.aws_vpc.main.cidr_block}"
}
