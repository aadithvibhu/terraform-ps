# Internet GW
#************

resource "aws_internet_gateway" "igw_main" {
    vpc_id = "${aws_vpc.main.id}"

    tags = {
        Name = "${var.project}_igw_main"
    }
}

# NAT Gateway
#**************

resource "aws_eip" "eip_main"{
  vpc      = true
}

resource "aws_nat_gateway" "ngw_main" {
  allocation_id = "${aws_eip.eip_main.id}"
  subnet_id = "${aws_subnet.public_subnet.id}"
  depends_on = [aws_internet_gateway.igw_main]
   
  tags = {
    Name = "${var.project}_ngw_main"
  }
}


# Route tables
#*************

resource "aws_route_table" "public-route" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "${var.default_route}"
        gateway_id = "${aws_internet_gateway.igw_main.id}"
    }
    tags = {
        Name = "${var.project}-public-route"
    }
}

resource "aws_route_table" "private-route" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "${var.default_route}"
        nat_gateway_id = "${aws_nat_gateway.ngw_main.id}"
    }

    tags = {
        Name = "${var.project}-private-route"
    }
}

# Route table associations
#*************************#

# Private
#********

resource "aws_route_table_association" "private-route-assoc" {
    subnet_id = "${aws_subnet.private_subnet.id}"
    route_table_id = "${aws_route_table.private-route.id}"
}

# Public
#********

resource "aws_route_table_association" "public-route-assoc" {
    subnet_id = "${aws_subnet.public_subnet.id}"
    route_table_id = "${aws_route_table.public-route.id}"
}

#***********************************

# Variables
#************

#variable project {}
#variable default_route {}
