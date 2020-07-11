provider aws {
   region = "ap-southeast-1"
}

data "aws_vpc" "dev" {
  filter {
    name = "tag:Name"
    values = ["enable-vpc"]
  }
}

###### Private Network  #######
data "aws_subnet_ids" "app_tier" {
  vpc_id = "${data.aws_vpc.dev.id}"
}

data "aws_subnet" "private_subnet" {
   filter {
    name = "tag:Name"
    values = ["sub-private-enable"]
  }
}
data "aws_security_groups" "dev_sg" {
  filter {
    name = "tag:Name"
    values = ["private_sg"]
        }
}

######## Public Network ##########
data "aws_subnet_ids" "web_tier" {
  vpc_id = "${data.aws_vpc.dev.id}"
}

data "aws_subnet" "public_subnet" {
   filter {
    name = "tag:Name"
    values = ["sub-public-enable"]
  }
}

data "aws_security_groups" "web_sg" {
  filter {
    name = "tag:Name"
    values = ["public_sg"]
        }
}
