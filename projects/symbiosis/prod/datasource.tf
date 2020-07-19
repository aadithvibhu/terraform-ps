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

data "aws_subnet" "private_subnet_1" {
   filter {
    name = "tag:Name"
    values = ["sub_private_${var.project}_1"]
  }
}
data "aws_subnet" "private_subnet_2" {
   filter {
    name = "tag:Name"
    values = ["sub_private_${var.project}_2"]
  }
}



######## Public Network ##########
data "aws_subnet_ids" "web_tier" {
  vpc_id = "${data.aws_vpc.main.id}"
}

data "aws_subnet" "public_subnet_1" {
   filter {
    name = "tag:Name"
    values = ["sub_public_${var.project}_1"]
  }
}

data "aws_subnet" "public_subnet_2" {
   filter {
    name = "tag:Name"
    values = ["sub_public_${var.project}_2"]
  }
}


##### Data Network #####################
data "aws_subnet_ids" "data_tier" {
  vpc_id = "${data.aws_vpc.main.id}"
}

data "aws_subnet" "data_subnet_1" {
   filter {
    name = "tag:Name"
    values = ["sub_data_${var.project}_1"]
  }
}

############################

data "aws_db_instance" "db" {
  db_instance_identifier = "symbiosis"
}
