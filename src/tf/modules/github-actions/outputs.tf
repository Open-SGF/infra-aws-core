output "dns_role_arn" {
  description = "IAM role ARN for infra-dns GitHub Actions."
  value       = aws_iam_role.github_actions_dns.arn
}

output "gh_role_arn" {
  description = "IAM role ARN for infra-gh GitHub Actions."
  value       = aws_iam_role.github_actions_gh.arn
}
