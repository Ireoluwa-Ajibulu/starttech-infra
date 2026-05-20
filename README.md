# StartTech Infrastructure

This repository contains the Terraform infrastructure code for the StartTech application.

## Architecture Overview

- VPC with public and private subnets across 2 availability zones
- Application Load Balancer for traffic distribution
- Auto Scaling Group for EC2 instances running the backend
- ElastiCache Redis cluster for caching and sessions
- S3 bucket for frontend static file hosting
- CloudFront CDN for global content delivery
- CloudWatch for logging and monitoring

# Prerequisites

- Terraform v1.14+
- AWS CLI v2+
- AWS account with appropriate permissions

# Setup

1. Clone the repository
git clone https://github.com/Ireoluwa-Ajibulu/starttech-infra

2. Configure AWS credentials
aws configure

3. Initialize Terraform
cd terraform
terraform init

4. Deploy infrastructure
terraform apply -auto-approve

# Details of the Infrastructur

 Resource

 Region - eu-west-1 
 ALB DNS - starttech-alb-79935896.eu-west-1.elb.amazonaws.com 
 S3 Bucket - starttech-frontend-production-468582173998 
 ECR Registry - 468582173998.dkr.ecr.eu-west-1.amazonaws.com 

# CI/CD Pipeline

The infrastructure pipeline runs automatically when changes are pushed to the terraform/ directory. It runs terraform plan on pull requests and terraform apply on merges to main.

# Monitoring

CloudWatch dashboards and alarms are configured for:
- EC2 CPU utilization
- ALB request count and response time
- Redis CPU and cache performance
