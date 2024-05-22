terraform {
  source          = "tfr://registry.terraform.io/RJPearson94/open-next/aws//modules/tf-aws-open-next-zone?version=3.0.0"
  include_in_copy = ["./.open-next"]
}

inputs = {
  prefix = "open-next-sz-${get_aws_account_id()}"
  folder_path = "./.open-next"
  s3_exclusion_regex = ".*\\.terragrunt*"

  continuous_deployment = {
    use = true
    deployment = "NONE"
    traffic_config = {
      header = {
        name = "aws-cf-cd-staging"
        value = "true"
      }
    }
  }
  
  website_bucket = {
    force_destroy = true
  }
}