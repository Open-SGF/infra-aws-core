locals {
  gh_github_subject              = "repo:Open-SGF@75648266/infra-gh@1338927123"
  gh_github_main_subject         = "${local.gh_github_subject}:ref:refs/heads/main"
  gh_github_pull_request_subject = "${local.gh_github_subject}:pull_request"
}

resource "aws_iam_role" "github_actions_gh" {
  name = "GitHubActionsInfraGHRole"

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
              local.gh_github_main_subject,
              local.gh_github_pull_request_subject,
            ]
          }
        }
      }
    ]
  })

  tags = {
    Environment          = "global"
    GitHubMainSubject    = local.gh_github_main_subject
    ManagedBy            = "OpenTofu"
    Name                 = "opensgf-github-actions-infra-gh-role"
    Repository           = "Open-SGF/infra-gh"
    TerraformStateKey    = "opensgf-infra-gh/terraform.tfstate"
    TerraformStatePrefix = "opensgf-infra-gh"
  }
}

resource "aws_iam_role_policy_attachment" "github_actions_gh_state" {
  role       = aws_iam_role.github_actions_gh.name
  policy_arn = aws_iam_policy.terraform_state_access.arn
}
