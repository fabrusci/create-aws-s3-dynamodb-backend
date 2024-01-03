terraform {
  required_version = ">= 0.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

provider "aws" {
  region = var.region
  profile = var.profile
}

provider "aws" {
  alias  = "replica"
  profile = var.profile
  region = var.replica_region
}

module "remote_state" {
  source = "git@github.com:nozaq/terraform-aws-remote-state-s3-backend"
  enable_replication = false
  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
}

resource "aws_iam_user" "terraform" {
  name = "TerraformUser"
}

resource "aws_iam_user_policy_attachment" "remote_state_access" {
  user       = aws_iam_user.terraform.name
  policy_arn = module.remote_state.terraform_iam_policy.arn
}
