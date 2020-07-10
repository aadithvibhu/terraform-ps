provider aws {
   region = "ap-southeast-1"

}

module my_vpc {
   source          = "../../modules/aws_vpc"
   vpc_cidr        = "10.0.0.0/16"
   sub_private_cidr = "10.0.1.0/27"
   project          = "enable"
}

module my_ec2 {
   source = "../../modules/aws_ec2"
   instance_count          = 1
   instance_type           = "t2.micro"
   instance_name           = "dev"
   subnet_id               = "${module.my_vpc.private_subnet}"
   subnet_type             = "private"
   user_data               = file("../scripts/apache.sh")
   volume_size             = 8
   vpc_id                  = "${module.my_vpc.vpc_id}"
   environment             = "dev"
   project                 = "enable"
}
