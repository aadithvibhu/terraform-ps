resource "aws_instance" "linux_instance" {
  count 	          = "${var.instance_count}"
  ami                     = "${lookup(var.linux_ami, var.aws_region)}"
  instance_type  	  = "${var.instance_type}"
  disable_api_termination = false
  monitoring              = true
  user_data    	 	  = "${var.user_data}"
  iam_instance_profile    = "${var.iam_instance_profile}"
  key_name                = "${var.key_name}"
  

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.volume_size}"
    delete_on_termination = true
  }

  tags			  = {
    Name                  = format("${var.instance_name}-%02d", count.index + 1)
    Type                  = "EC2 Instance"
    Monitoring            = "true"
    Environment           = "${var.environment}"
    Project               = "${var.project}"
	 }

}


resource "aws_key_pair" "kp_devops" {
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCFdUVSAiXTc8NLWxEFa6AwCYgH2Tuzr3zIFrGWHQ2M+JDGzXSwKjNoS+pMTu6ypoZPg7O8Z54TMOvZv9cGTXGs/73IZ6n/RvGymiWWe0khOeUBPSiFfSUUiWwWyb5X4yqliVUaPbzvoq94QByrIHT02Y6iapojqYKobBw4lWZhTuDB35xySMf/eFx3h2t5df+ZLXi50DYswReHylBEvH32rLrqeMv1IMMgwy4db2kQQjj2IhjGsQ0anN6rfNZbePwOJhHnLxot+vLdX6DV3H5MlZz2XjJrPqJoIwRt6zIpyxzsj5eJx2y8Ay7ncTifB0S/P5SsbsCSN6PIHBeaX1An jaas"
}


resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "Allow inbound traffic"
  vpc_id      = "${var.vpc_id}"
  tags = {
    Name                     = "public_sg"
    Type                     = "EC2 Security Group"
    Monitoring               = "true"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  description = "Allow inbound traffic"
  vpc_id      = "${var.vpc_id}"
  tags = {
    Name                     = "private_sg"
    Type                     = "EC2 Security Group"
    Monitoring               = "true"
  }
}

resource "aws_security_group" "data_sg" {
  name        = "data_sg"
  description = "Allow inbound traffic"
  vpc_id      = "${var.vpc_id}"
  tags = {
    Name                     = "data_sg"
    Type                     = "database Security Group"
    Monitoring               = "true"
  }
}





###################################
#variables
#*********
variable "linux_ami" {
   type = map(string)
   default = {
    ap-southeast-1 = "ami-0615132a0f36d24f4"
        }
}

variable aws_region {
      default = "ap-southeast-1"
}
variable vpc_id {}
variable instance_count {}
variable instance_type {}
variable instance_name {}
variable subnet_id {}
variable subnet_type {}
variable volume_size {}
variable user_data {}
variable iam_instance_profile {
  default = "ec2admin"
}
variable key_name {
  default = "kp_devops"
}
variable environment {}
variable project {}



##########################################
#outputs

output pub_sg {
   value = "${aws_security_group.public_sg}"
}

output priv_sg {
   value = "${aws_security_group.private_sg}"
}
output data_sg {
   value = "${aws_security_group.data_sg}"
}

