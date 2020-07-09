resource "aws_instance" "webserver" {
  count                   = 1
  ami                     = "${lookup(var.ami_devops, var.aws_region)}"
  instance_type           = "t2.micro"
  iam_instance_profile    = "ec2admin"
  key_name                = "${aws_key_pair.kp_devops.key_name}"
  monitoring              = true
  user_data               = file("../scripts/bootstrap.sh")
  disable_api_termination = false
  subnet_id		  = module.vpc.public_subnet
  vpc_security_group_ids  = [
    "${aws_security_group.sg_devops.id}"
  ]

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }

  tags = {
    Name                     = format("webserver-%02d", count.index + 1)
    Type                     = "EC2 Instance"
    Monitoring               = "true"
 }

  provisioner "local-exec" {
    command = "cd ../../playbooks && ansible-playbook apache.yml -i hosts"
  }
}
