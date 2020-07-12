provider aws {
   region = "${var.region}"
}
module prod_vpc {
   source           = "../../../../../modules/aws-vpc"
   vpc_cidr         = "${var.vpc_cidr}"
   sub_public_cidr  = "${var.sub_public_cidr}"
   sub_private_cidr = "${var.sub_private_cidr}"
   sub_data_cidr    = "${var.sub_data_cidr}"
   project          = "${var.project}"
   environment      = "${var.environment}"
}
