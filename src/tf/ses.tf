locals {
  ses_email_identity   = "opensgf.org"
  ses_mail_from_domain = "bounce.${local.ses_email_identity}"
}

resource "aws_sesv2_email_identity" "opensgf_org" {
  email_identity = local.ses_email_identity

  tags = merge(
    var.tags,
    {
      ManagedBy = "OpenTofu"
    }
  )
}

resource "aws_sesv2_email_identity_mail_from_attributes" "opensgf_org" {
  email_identity = aws_sesv2_email_identity.opensgf_org.email_identity

  behavior_on_mx_failure = "USE_DEFAULT_VALUE"
  mail_from_domain       = local.ses_mail_from_domain
}
