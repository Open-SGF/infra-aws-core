output "backend_bucket_name" {
  description = "S3 bucket name for OpenTofu state storage."
  value       = aws_s3_bucket.tfstate_state.bucket
}

output "backend_table_name" {
  description = "DynamoDB table name for state locking."
  value       = aws_dynamodb_table.tflock_state.name
}

output "github_actions_role_arn" {
  description = "IAM role ARN for GitHub Actions OIDC authentication."
  value       = aws_iam_role.github_actions_terraform.arn
  sensitive   = true
}

output "ses_email_identity_arn" {
  description = "ARN of the SES identity used for outbound email."
  value       = aws_sesv2_email_identity.opensgf_org.arn
}

output "ses_mail_from_domain" {
  description = "Custom MAIL FROM domain used by SES."
  value       = aws_sesv2_email_identity_mail_from_attributes.opensgf_org.mail_from_domain
}
