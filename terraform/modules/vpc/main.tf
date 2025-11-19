resource "aws_vpc" "this" {
  cidr_block = var.cidr
  tags = { Name = "auto-vpc" }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 0)
  map_public_ip_on_launch = true
  tags = { Name = "auto-public-subnet" }
}

resource "aws_internet_gateway" "igw" { vpc_id = aws_vpc.this.id }

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.this.id
  route { cidr_block = "0.0.0.0/0"; 
     	  gateway_id = aws_internet_gateway.igw.id 
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.r.id
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "allow ssh and http"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

output "public_subnet_id" { value = aws_subnet.public.id }
output "web_sg_id" { value = aws_security_group.web_sg.id }

