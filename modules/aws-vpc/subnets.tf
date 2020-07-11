# Subnets
#********

resource "aws_subnet" "public_subnet" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_public_cidr}"

    tags = {
        Name = "sub_public_${var.project}"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_private_cidr}"

    tags = {
        Name = "sub_private_${var.project}"
    }
}

resource "aws_subnet" "data_subnet" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_data_cidr}"

    tags = {
        Name = "sub_private_${var.project}"
    }
}


#********* Variables **********

#variable sub_public_cidr {}
#variable sub_private_cidr {}
#variable sub_data_cidr {}
#variable project {}


#********** Outputs ************

output "public_subnet" {
  value       = aws_subnet.public_subnet.id
}
output "private_subnet" {
  value       = aws_subnet.private_subnet.id
}
output "data_subnet" {
  value       = aws_subnet.data_subnet.id
}
