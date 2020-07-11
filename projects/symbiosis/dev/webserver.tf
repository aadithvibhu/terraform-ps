module "webserver" {
    source = "../modules/aws-ec2"
    instance_count          = 1
    instance_type           = "t2.micro"
    instance_name           = "webserver"
    user_data               = file("../scripts/apache.sh")
    volume_size             = 8
    vpc_id                  = "${data.aws_vpc.main.id}"
    environment             = "${var.environment}"
    project                 = "${var.project}"
    subnet_type             = "public"
    subnet_id               = "${data.aws_subnet.public_subnet.id}"
    sg_id                   = "${data.aws_security_groups.web_sg.id}"
}
