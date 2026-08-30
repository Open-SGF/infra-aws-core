variable "oidc_provider_arn" {
  description = "ARN of the GitHub Actions OIDC provider."
  type        = string
}

variable "ses_identity_arn" {
  description = "ARN of the SES identity read by infra-dns."
  type        = string
}

variable "state_bucket_arn" {
  description = "ARN of the shared OpenTofu state bucket."
  type        = string
}

variable "state_bucket_name" {
  description = "Name of the shared OpenTofu state bucket."
  type        = string
}

variable "state_lock_table_arn" {
  description = "ARN of the shared OpenTofu state lock table."
  type        = string
}
