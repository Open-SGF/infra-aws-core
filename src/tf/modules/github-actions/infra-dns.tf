locals {
  dns_github_subject              = "repo:Open-SGF@75648266/infra-dns@1308369426"
  dns_github_main_subject         = "${local.dns_github_subject}:ref:refs/heads/main"
  dns_github_pull_request_subject = "${local.dns_github_subject}:pull_request"
}

resource "aws_iam_role" "github_actions_dns" {
  name = "GitHubActionsInfraDNSRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
            "token.actions.githubusercontent.com:sub" = [
              local.dns_github_main_subject,
              local.dns_github_pull_request_subject,
            ]
          }
        }
      }
    ]
  })

  tags = {
    Environment          = "global"
    GitHubMainSubject    = local.dns_github_main_subject
    ManagedBy            = "OpenTofu"
    Name                 = "opensgf-github-actions-infra-dns-role"
    Repository           = "Open-SGF/infra-dns"
    TerraformStateKey    = "opensgf-infra-dns/terraform.tfstate"
    TerraformStatePrefix = "opensgf-infra-dns"
  }
}

resource "aws_iam_role_policy_attachment" "github_actions_dns_state" {
  role       = aws_iam_role.github_actions_dns.name
  policy_arn = aws_iam_policy.terraform_state_access.arn
}

resource "aws_iam_role_policy" "github_actions_dns" {
  name = "InfraDNSRepositoryAccess"
  role = aws_iam_role.github_actions_dns.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ReadSESIdentity"
        Effect = "Allow"
        Action = [
          "ses:GetEmailIdentity",
          "ses:ListTagsForResource",
        ]
        Resource = var.ses_identity_arn
      },
    ]
  })
}
