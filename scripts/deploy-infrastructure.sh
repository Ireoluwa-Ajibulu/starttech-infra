#!/bin/bash
set -e

echo " Deploying StartTech Infrastructure..."


AWS_REGION="eu-north-1"
TF_DIR="$(dirname "$0")/../terraform"


command -v terraform >/dev/null 2>&1 || { echo " Terraform is required but not installed."; exit 1; }
command -v aws >/dev/null 2>&1 || { echo " AWS CLI is required but not installed."; exit 1; }


echo " Checking AWS credentials..."
aws sts get-caller-identity >/dev/null 2>&1 || { echo " AWS credentials not configured."; exit 1; }
echo " AWS credentials verified"


echo " Initializing Terraform..."
cd $TF_DIR
terraform init


echo " Validating Terraform configuration..."
terraform validate

echo "Planning infrastructure changes..."
terraform plan -out=tfplan


read -p "Do you want to apply these changes? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
  echo " Deployment cancelled."
  exit 0
fi


echo "Applying infrastructure changes..."
terraform apply tfplan

echo " Infrastructure deployed successfully!"
terraform output
