module "github_actions" {
  source = "./modules/github-actions"

  oidc_provider_arn    = aws_iam_openid_connect_provider.github_actions.arn
  ses_identity_arn     = aws_sesv2_email_identity.opensgf_org.arn
  state_bucket_arn     = aws_s3_bucket.tfstate_state.arn
  state_bucket_name    = aws_s3_bucket.tfstate_state.bucket
  state_lock_table_arn = aws_dynamodb_table.tflock_state.arn
}
