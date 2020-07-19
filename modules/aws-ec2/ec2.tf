resource "aws_network_interface" "main" {
  subnet_id       = "${var.subnet_id}"
}
########################################
resource "aws_instance" "linux_instance" {
  count 	          = "${var.instance_count}"
  ami                     = "${lookup(var.linux_ami, var.aws_region)}"
  instance_type  	  = "${var.instance_type}"
  disable_api_termination = false
  monitoring              = true
  user_data    	 	  = "${var.user_data}"
  iam_instance_profile    = "${var.iam_instance_profile}"
  key_name                = "${var.key_name}"
  subnet_id               = "${var.subnet_id}"
  associate_public_ip_address  = "${var.public_ip}"
 

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

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  count                = "${var.instance_count}"
  security_group_id    = "${aws_security_group.private_sg.id}"
  network_interface_id = "${element(aws_instance.linux_instance.*.primary_network_interface_id, count.index)}"
}

resource "aws_key_pair" "kp_devops" {
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCFdUVSAiXTc8NLWxEFa6AwCYgH2Tuzr3zIFrGWHQ2M+JDGzXSwKjNoS+pMTu6ypoZPg7O8Z54TMOvZv9cGTXGs/73IZ6n/RvGymiWWe0khOeUBPSiFfSUUiWwWyb5X4yqliVUaPbzvoq94QByrIHT02Y6iapojqYKobBw4lWZhTuDB35xySMf/eFx3h2t5df+ZLXi50DYswReHylBEvH32rLrqeMv1IMMgwy4db2kQQjj2IhjGsQ0anN6rfNZbePwOJhHnLxot+vLdX6DV3H5MlZz2XjJrPqJoIwRt6zIpyxzsj5eJx2y8Ay7ncTifB0S/P5SsbsCSN6PIHBeaX1An jaas"
}


###################################
#variables
#*********
variable "linux_ami" {
   type = map(string)
   default = {
    ap-southeast-1 = "ami-0d6c336fc1df6d884"
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
variable environment {
     default = "prod"
}
variable project {
    default = "symbiosis"
}
variable public_ip {}

#######################################o###
