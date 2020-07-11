provider aws {
   region = "${var.region}"
}

data "aws_vpc" "main" {
  filter {
    name = "tag:Name"
    values = ["${var.project}-vpc"]
  }
}

###### Private Network  #######
data "aws_subnet_ids" "app_tier" {
  vpc_id = "${data.aws_vpc.main.id}"
}

data "aws_subnet" "private_subnet" {
   filter {
    name = "tag:Name"
    values = ["sub-private-${var.project}"]
  }
}
data "aws_security_groups" "app_sg" {
  filter {
    name = "tag:Name"
    values = ["${var.project}_private_sg"]
        }
}

######## Public Network ##########
data "aws_subnet_ids" "web_tier" {
  vpc_id = "${data.aws_vpc.main.id}"
}

data "aws_subnet" "public_subnet" {
   filter {
    name = "tag:Name"
    values = ["sub-public-${var.project}"]
  }
}

data "aws_security_groups" "web_sg" {
  filter {
    name = "tag:Name"
    values = ["${var.project}_public_sg"]
        }
}
