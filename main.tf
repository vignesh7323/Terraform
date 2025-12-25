resource "aws_vpc" "vpc1" {
        cidr_block = var.vpc_cidr

        tags = {
          Name = var.vpc_name
        }

}

resource "aws_security_group" "Sg_public_subnet" {
    vpc_id = aws_vpc.vpc1.id

    ingress {
        description = "Allow http from anywhere"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 80
        to_port = 80
        protocol = "tcp"
    }

    egress {
        description = "Allow all outgoing traffic"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
  
}


resource "aws_security_group" "Sg_private_subnet" {
    vpc_id = aws_vpc.vpc1.id

    ingress {
        description = "Allow ssh from anywhere"
        cidr_blocks = [#your private IP/32]
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }

    egress {
        description = "Allow all outgoing traffic"
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
  
}

resource "aws_instance" "Terraform_Public_instance" {
    depends_on = [ aws_security_group.Sg_public_subnet ]
    count = 2
    ami = var.Ec2_ami
    instance_type = var.Ec2_type
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.Sg_public_subnet.id]
        tags = {
          Name = "Terraform_Public_instance-${count.index}"
        }
  
}

resource "aws_instance" "Terraform_private_instance" {
    depends_on = [ aws_security_group.Sg_private_subnet ]
    count = 2
    ami = var.Ec2_ami
    instance_type = var.Ec2_type
    subnet_id = aws_subnet.private.id
    vpc_security_group_ids = [aws_security_group.Sg_private_subnet.id]
        tags = {
          Name = "Terraform_private_instance-${count.index}"
        }
  
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.public_subnet
}


resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = var.private_subnet
}