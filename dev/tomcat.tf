resource "aws_instance" "appserver" {
  count                   = 2
  ami                     = "${lookup(var.ami_devops, var.aws_region)}"
  instance_type           = "t2.micro"
  iam_instance_profile    = "ec2admin"
  key_name                = "${aws_key_pair.kp_devops.key_name}"
  monitoring              = true
  user_data               = file("../scripts/bootstrap.sh")
  disable_api_termination = false
  subnet_id		  = module.vpc.private_subnet
  vpc_security_group_ids  = [
    "${aws_security_group.sg_devops.id}"
  ]

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }

  tags = {
    Name                     = format("appserver-%02d", count.index + 1)
    Type                     = "EC2 Instance"
    Monitoring               = "true"
 }
 provisioner "local-exec" {
    command = "cd ../../playbooks && ansible-playbook tomcat.yml -i hosts"
  }

}

module "custopostdb" {
  source = "../modules/aws-rds-mysql"

  alarm_cpu_threshold         = "75"
  alarm_disk_queue_threshold  = "10"
  alarm_free_disk_threshold   = "5000000"
  alarm_free_memory_threshold = "1280000"
  engine_version              = "5.7.22"
  instance_type               = "db.t2.micro"
  db_name                     = "mysqldb"
  db_port                     = "3306"
  multiaz                     = false
  storage_size                = "20"
  skip_final_snapshot         = true
  final_snapshot_identifier   = ""
  vpc_id		      = module.vpc.vpc_id
  subnet_ids                  = ["module.vpc.data_subnet"]
}
