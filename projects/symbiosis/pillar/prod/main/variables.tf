variable vpc_cidr {
    default = "10.0.0.0/16"
}
variable sub_public_cidr_1 {
    default = "10.0.1.0/27"
}
variable sub_public_cidr_2 {
    default = "10.0.2.0/27"
}

variable sub_private_cidr_1 {
    default = "10.0.3.0/27"
}

variable sub_private_cidr_2 {
    default = "10.0.4.0/27"
}

variable sub_data_cidr_1 {
    default = "10.0.5.0/27"
}

variable sub_data_cidr_2{
    default = "10.0.6.0/27"
}

variable project {
     default = "symbiosis"
}

variable environment {
     default = "prod"
}
variable region {
   default = "ap-southeast-1"
}

variable "avz" {
  type = "map"
  default = {
   a = "ap-southeast-1a"
   b = "ap-southeast-1b"
   c = "ap-southeast-1c"
	}
}
