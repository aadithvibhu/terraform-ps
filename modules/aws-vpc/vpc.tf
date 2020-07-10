# Internet VPC
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "${var.project}-vpc"
    }
}


# Subnets
#********

resource "aws_subnet" "sub_private_devops" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_private_cidr}"

    tags = {
        Name = "sub_private_devops"
    }
}



##################################
variable vpc_cidr {}
variable sub_private_cidr {}
variable project {}





##################################

output "vpc_id" {
     value   = aws_vpc.main.id
}

output "private_subnet" {
  value       = aws_subnet.sub_private_devops.id
}
