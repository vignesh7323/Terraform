#vpc name
variable "vpc_name" {
    type = string
    description = "production_vpc_name"  
}

variable "vpc_cidr" {
    type= string
    description = "vpc ip block" 
}

variable "private_subnet" {
    type = string
    description = "private subnet"
}

variable "public_subnet" {
    type = string
    description = "public subnet"
  
}

variable "Ec2_count" {
    type = number
    description = "server count"
    default = 2
}

variable "Ec2_ami" {
    type = string
}

variable "Ec2_type" {
    type = string 
}


