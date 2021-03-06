variable project {}
variable default_route {
    default = "0.0.0.0/0"
}

variable sub_public_cidr_1 {}
variable sub_public_cidr_2 {}
variable sub_private_cidr_1 {}
variable sub_private_cidr_2 {}
variable sub_data_cidr_1 {}
variable sub_data_cidr_2 {}
variable avz {}

variable vpc_cidr {}
variable environment {}
variable app_port {
     default = "8080"
}
variable web_port {
     default = "8000"
}
variable db_port {
     default = "3306"
}
