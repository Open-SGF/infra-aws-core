terraform {
  backend "s3" {
    bucket         = "opensgf-infra-tf-state"
    key            = "opensgf-infra-aws-core/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "opensgf-infra-tflock"
    encrypt        = true
  }
}
