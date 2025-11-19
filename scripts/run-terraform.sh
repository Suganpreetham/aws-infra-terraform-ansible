#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/../terraform"
# make sure you exported AWS creds in env or use profile
# Example: export AWS_PROFILE=default
terraform init
terraform apply -auto-approve -var "ssh_public_key=$(cat ~/.ssh/auto_aws_key.pub)" -var "ami_id=ami-PLACEHOLDER"

