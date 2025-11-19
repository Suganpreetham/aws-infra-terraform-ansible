variable "aws_region" { default = "us-east-1" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "instance_count" { default = 1 }
variable "instance_type" { default = "t3.micro" }
variable "ami_id" { description = "Ubuntu 22.04 AMI id" }
variable "ssh_public_key" { description = "Your SSH public key (content)" }

