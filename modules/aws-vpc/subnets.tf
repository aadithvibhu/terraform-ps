# Subnets
#********

resource "aws_subnet" "public_subnet_1" {
    availability_zone = "${var.avz.a}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_public_cidr_1}"

    tags = {
        Name = "sub_public_${var.project}_1"
    }
}
resource "aws_subnet" "public_subnet_2" {
    availability_zone = "${var.avz.b}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_public_cidr_2}"

    tags = {
        Name = "sub_public_${var.project}_2"
    }
}


resource "aws_subnet" "private_subnet_1" {
    availability_zone = "${var.avz.a}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_private_cidr_1}"

    tags = {
        Name = "sub_private_${var.project}_1"
    }
}

resource "aws_subnet" "private_subnet_2" {
    availability_zone = "${var.avz.b}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_private_cidr_2}"

    tags = {
        Name = "sub_private_${var.project}_2"
    }
}

resource "aws_subnet" "data_subnet_1" {
    availability_zone = "${var.avz.a}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_data_cidr_1}"

    tags = {
        Name = "sub_data_${var.project}_1"
    }
}

resource "aws_subnet" "data_subnet_2" {
     availability_zone = "${var.avz.b}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_data_cidr_2}"

    tags = {
        Name = "sub_data_${var.project}_2"
    }
}


#********* Variables **********

#variable sub_public_cidr_1 {}
#variable sub_public_cidr_2 {}
#variable sub_private_cidr_1 {}
#variable sub_private_cidr_2 {}
#variable sub_data_cidr_1 {}
#variable sub_data_cidr_2 {}
#variable project {}
#variable avz {}

#********** Outputs ************

output "public_subnet_1" {
  value       = aws_subnet.public_subnet_1.id
}
output "private_subnet_1" {
 value       = aws_subnet.private_subnet_1.id
}
output "data_subnet_1" {
  value       = aws_subnet.data_subnet_1.id
}

output "public_subnet_2" {
  value       = aws_subnet.public_subnet_2.id
}
output "private_subnet_2" {
 value       = aws_subnet.private_subnet_2.id
}
output "data_subnet_2" {
  value       = aws_subnet.data_subnet_2.id
}

