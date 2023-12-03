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
    default_action = {
      action = "BLOCK"
      block_action = {
        response_code = 503
        custom_response_body_key = "maintainance"
      }
    }
    custom_response_bodies = [{
      key = "maintainance"
      content = file("./static/503.html")
      content_type = "TEXT_HTML"
    }]
  }
}