# aws-infra-terraform-ansible
This project automates the complete setup of a web-server environment on AWS using Terraform, Ansible, NGINX, and Shell scripting.

This project takes the entire process of setting up a web server on AWS and turns it into a fully automated workflow.
No clicking buttons in the AWS console, no manual SSH setup — everything happens automatically.

First, the infrastructure is created automatically using Terraform. It builds the whole network setup: a VPC, subnet, route table, internet gateway, and the security groups needed for SSH and HTTP access. After that, it launches an EC2 instance without touching anything.
Once the server is up, the configuration part happens. A shell script generates fresh SSH keys, sets up passwordless access, and Ansible takes over to install and configure NGINX. It also pushes the static website files to the EC2 machine so the web server is ready.

When everything is done, the entire environment can be brought online in a few minutes using two commands:

1.terraform apply

2.ansible-playbook site.yml

**Technologies Used:**

1.**Terraform**
Handles all AWS provisioning — VPC, subnets, security groups, and EC2 — using reusable modules. It builds the entire infra the same way every time.

2.**Ansible**
Takes over after the server is created. Installs NGINX, deploys web content, and connects to the EC2 instance using dynamic inventory and passwordless SSH.

3.**AWS**
EC2 for the server, VPC for networking, Internet Gateway for internet access, and Security Groups for traffic control.

4.**NGINX**
Serves the static site, fully installed and configured by Ansible.

5.**Shell Scripts**
Generate SSH keys and prep everything so Terraform and Ansible can run without manual steps.
