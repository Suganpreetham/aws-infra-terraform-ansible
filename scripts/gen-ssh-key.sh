#!/usr/bin/env bash
set -e
KEY="$HOME/.ssh/auto_aws_key"
if [ -f "$KEY" ]; then
  echo "Key exists: $KEY"
  exit 0
fi
ssh-keygen -t ed25519 -f "$KEY" -N ""
echo "Generated $KEY and $KEY.pub"

