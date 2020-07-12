output "db_address" {
  value = "${aws_db_instance.mod_rds.address}"
}

output "db_endpoint" {
  value = "${aws_db_instance.mod_rds.endpoint}"
}

output "db_user" {
  value = "${aws_db_instance.mod_rds.username}"
}
output "db_subnet_group_id" {
  value = "${aws_db_subnet_group.db_subnet_group.id}"
}

output "db_security_group_id" {
  value = "${aws_security_group.db_security_group.id}"
}
