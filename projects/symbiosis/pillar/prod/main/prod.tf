provider aws {
   region = "${var.region}"
}
module prod_vpc {
   source           = "../../../../../modules/aws-vpc"
   vpc_cidr         = "${var.vpc_cidr}"
   sub_public_cidr_1  = "${var.sub_public_cidr_1}"
   sub_public_cidr_2  = "${var.sub_public_cidr_2}"
   sub_private_cidr_1 = "${var.sub_private_cidr_1}"
   sub_private_cidr_2 = "${var.sub_private_cidr_2}"
   sub_data_cidr_1    = "${var.sub_data_cidr_1}"
   sub_data_cidr_2    = "${var.sub_data_cidr_2}"
   project            = "${var.project}"
   environment        = "${var.environment}"
   avz                = "${var.avz}"
}
