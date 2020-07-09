variable "default_route" {
    default = "0.0.0.0/0"
}

variable "ami_devops" {
   type = map(string)
   default = {
    ap-southeast-1 = "ami-0615132a0f36d24f4"
  }

}
variable "aws_region" {
  default = "ap-southeast-1"
}

variable "engine_version" { default = "" }

variable "instance_type" { default = "" }
variable "vpc_cidr" { default = "" }
