module enable_nonprod_vpc {
   source           = "../../../modules/main-vpc"
   vpc_cidr         = "10.0.0.0/16"
   sub_public_cidr  = "10.0.1.0/27"
   sub_private_cidr = "10.0.2.0/27"
   sub_data_cidr    = "10.0.3.0/27"
   project          = "enable"
   environment      = "Non-Production"
