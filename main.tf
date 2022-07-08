terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "./credentials"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "demo"
  cidr = "10.10.0.0/16"
  azs             = ["us-east-1a"]
  private_subnets = ["10.10.220.0/24"]
  public_subnets  = ["10.10.110.0/24"]
  enable_nat_gateway = true

  tags = {
    Environment = "demo"
  }

}


resource "aws_security_group" "ec2" {
  name   = "ec2_access"
  vpc_id = "${module.vpc.vpc_id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["10.10.0.0/16"]
  }
  
  ingress {
    from_port   = 30008
    to_port     = 30008
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
      ignore_changes = all
  }
}


resource "aws_instance" "ec2" {
    for_each = var.hostname
    ami                         = "ami-08d4ac5b634553e16"
    subnet_id                   = "${module.vpc.public_subnets[0]}"
    instance_type               = "t3.medium"
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2.id]
    user_data    =  <<-EOF
        #!/bin/bash 
        sudo hostnamectl set-hostname ${each.value}
        sudo useradd ubuntu -m -s /bin/bash  2>/dev/null
        echo ${var.key_devops} >> /home/ubuntu/.ssh/authorized_keys
    EOF
    tags = {
        Name = "${each.value}"	
    }
    

}


output "ec2_ip" {
   value = {
    for k,i in aws_instance.ec2 :  k=>i.public_ip  
   }
}

output "ec2_ip_out" {
   value = ["${aws_instance.ec2["master"].public_ip}"]
}
