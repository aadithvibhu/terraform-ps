module "appserver" {
    source = "../modules/aws-ec2"
    instance_count          = 1
    instance_type           = "t2.micro"
    instance_name           = "appserver"
    user_data               = file("../scripts/apache.sh")
    volume_size             = 8
    vpc_id                  = "${data.aws_vpc.dev.id}"
    environment             = "dev"
    project                 = "enable"
    subnet_type             = "private"
    subnet_id               = "${data.aws_subnet.private_subnet.id}"
    sg_id                   = "${data.aws_security_groups.dev_sg.id}"
}
