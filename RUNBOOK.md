# StartTech Runbook

# Deploying infrastructure changes

cd terraform
terraform plan
terraform apply -auto-approve

# Checking if the app is running

aws elbv2 describe-target-health --target-group-arn <target-group-arn>

# Viewing application logs

aws logs tail starttech-app-logs --follow

# Restarting the backend

aws ssm send-command \
  --targets "Key=tag:aws:autoscaling:groupName,Values=starttech-asg" \
  --document-name "AWS-RunShellScript" \
  --parameters commands=["docker restart starttech-backend"]

# Rolling back to a previous version

cd scripts
./rollback.sh <image-tag>

# Scaling up manually

aws autoscaling set-desired-capacity \
  --auto-scaling-group-name starttech-asg \
  --desired-capacity 2

# issues that may arise

High CPU - the Auto Scaling Group will handle this automatically. Check CloudWatch alarms for details.

502 errors - check if the Docker container is running on EC2.
Pipeline failed - check GitHub Actions logs and verify all secrets are set.
