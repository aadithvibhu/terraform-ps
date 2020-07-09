# Internet VPC
resource "aws_vpc" "vpc_devops" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "vpc_devops"
    }
}

# Subnets
#********

resource "aws_subnet" "sub_public_devops" {
    vpc_id = "${aws_vpc.vpc_devops.id}"
    cidr_block = "${var.sub_public_cidr}"
    availability_zone = "${var.avz.av-a}"

    tags = {
        Name = "sub_public_devops"
    }
}

resource "aws_subnet" "sub_private_devops" {
    vpc_id = "${aws_vpc.vpc_devops.id}"
    cidr_block = "${var.sub_private_cidr}"
    availability_zone = "${var.avz.av-a}"

    tags = {
        Name = "sub_private_devops"
    }
}

resource "aws_subnet" "sub_data_devops" {
    vpc_id = "${aws_vpc.vpc_devops.id}"
    cidr_block = "${var.sub_data_cidr}"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.avz.av-a}"

    tags = {
        Name = "sub_data_devops"
    }
}


resource "aws_network_acl" "nacl_devops" {
  vpc_id = "${aws_vpc.vpc_devops.id}"

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.default_route}"
    from_port  = 8080
    to_port    = 8080
  }

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${var.default_route}"
    from_port  = 8080
    to_port    = 8080
  }
  tags = {
    Name = "nacl_devops"
  }
}

# Internet GW
#************

resource "aws_internet_gateway" "igw_devops" {
    vpc_id = "${aws_vpc.vpc_devops.id}"

    tags = {
        Name = "igw_devops"
    }
}

# NAT Gateway
#**************

resource "aws_eip" "eip_devops"{
  vpc      = true
}

resource "aws_nat_gateway" "ngw_devops" {
  allocation_id = "${aws_eip.eip_devops.id}"
  subnet_id = "${aws_subnet.sub_public_devops.id}"
  depends_on = [aws_internet_gateway.igw_devops]
}


# Route tables
#*************

resource "aws_route_table" "public-route" {
    vpc_id = "${aws_vpc.vpc_devops.id}"
    route {
        cidr_block = "${var.default_route}"
        gateway_id = "${aws_internet_gateway.igw_devops.id}"
    }
    tags = {
        Name = "public-route"
    }
}

resource "aws_route_table" "private-route" {
    vpc_id = "${aws_vpc.vpc_devops.id}"
    route {
        cidr_block = "${var.default_route}"
        nat_gateway_id = "${aws_nat_gateway.ngw_devops.id}"
    }

    tags = {
        Name = "private-route"
    }
}

# Route table associations
#*************************#

# Private
#********

resource "aws_route_table_association" "private-route-assoc" {
    subnet_id = "${aws_subnet.sub_private_devops.id}"
    route_table_id = "${aws_route_table.private-route.id}"
}

# Public
#********

resource "aws_route_table_association" "public-route-assoc" {
    subnet_id = "${aws_subnet.sub_public_devops.id}"
    route_table_id = "${aws_route_table.public-route.id}"
}

