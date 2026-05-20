output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.frontend.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.frontend.arn
}

output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = "pending-aws-verification"
}

output "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = "pending-aws-verification"
}
