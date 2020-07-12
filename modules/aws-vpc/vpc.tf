# Internal VPC
#***************
resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "${var.project}-vpc"
        Environment = "${var.environment}"
    }
}

#********* Variables **********
#variable vpc_cidr {}
#variable project {}
#variable environment {}


#********** Outputs ************

output "vpc_id" {
     value   = aws_vpc.main.id
}
