variable vpc_cidr {
    default = "10.0.0.0/16"
}
variable sub_public_cidr {
    default = "10.0.1.0/27"
}
variable sub_private_cidr {
    default = "10.0.2.0/27"
}
variable sub_data_cidr {
    default = "10.0.3.0/27"
}
variable project {}
variable environment {}
variable region {}
