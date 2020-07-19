module "webserver" {
    source = "../../../modules/aws-ec2"
    instance_count          = 1
    instance_type           = "t2.micro"
    instance_name           = "webserver"
    user_data               = file("../../../scripts/symbiosis.sh")
    volume_size             = 8
    vpc_id                  = "${data.aws_vpc.main.id}"
    environment             = "${var.environment}"
    project                 = "${var.project}"
    subnet_type             = "public"
    subnet_id               = "${data.aws_subnet.public_subnet_1.id}"
    #subnets_ids            = ["${data.aws_subnet.public_subnet_1.id}", "${data.aws_subnet.private_subnet_2.id}"]
    public_ip               = false
    vpc_cidr_blocks         = "${data.aws_vpc.main.cidr_block}"
}
