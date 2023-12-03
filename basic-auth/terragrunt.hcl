locals {
  credentials = yamldecode(file("${path_relative_from_include()}/credentials.yaml"))
}

terraform {
  source          = "tfr://registry.terraform.io/RJPearson94/open-next/aws//modules/tf-aws-open-next-zone?version=2.0.0"
  include_in_copy = ["./.open-next"]
}

inputs = {
  prefix = "open-next-auth-${get_aws_account_id()}"
  folder_path = "./.open-next"
  s3_exclusion_regex = ".*\\.terragrunt*"

  waf = {
    deployment = "CREATE"
    aws_managed_rules = []
    enforce_basic_auth = {
      enabled = true
      credentials = {
        username = local.credentials["username"]
        password = local.credentials["password"]
      }
    }
  }
}