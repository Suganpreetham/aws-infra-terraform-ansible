variable "instance_count" {}
variable "instance_type" {}
variable "ami_id" {}
variable "subnet_id" {}
variable "ssh_authorized_key" {}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.tpl")
  vars = {
    ssh_pubkey = var.ssh_authorized_key
  }
}

resource "aws_instance" "web" {
  key_name               = aws_key_pair.ansible_key.key_name
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  user_data              = data.template_file.user_data.rendered
  vpc_security_group_ids = [var.web_sg_id]
  tags                   = { Name = "auto-web-${count.index}" }
}

resource "aws_key_pair" "ansible_key" {
  key_name   = "auto-aws-key"
  public_key = file("~/.ssh/auto_aws_key.pub")
}

output "public_ips" {
  value = aws_instance.web[*].public_ip
}

