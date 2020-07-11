provider aws {
  region = "ap-southeast-1"
}
module efresh_nonprod_vpc {
   source           = "../../../modules/aws-vpc"
   vpc_cidr         = "10.0.0.0/16"
   sub_public_cidr  = "10.0.1.0/27"
   sub_private_cidr = "10.0.2.0/27"
   sub_data_cidr    = "10.0.3.0/27"
   project          = "efresh"
   environment      = "Non-Production"
}
