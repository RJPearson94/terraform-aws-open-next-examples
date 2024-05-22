terraform {
  source          = "tfr://registry.terraform.io/RJPearson94/open-next/aws//modules/tf-aws-open-next-multi-zone?version=3.0.0"
  include_in_copy = ["./docs/.open-next", "./home/.open-next"]
}

inputs = {
  prefix = "open-next-mz-${get_aws_account_id()}"
  deployment = "SHARED_DISTRIBUTION"

  s3_exclusion_regex  = ".*\\.terragrunt*"
  zones = [{
    root = true
    name = "home"
    folder_path = "./home/.open-next"
  },{
    root = false
    name = "docs"
    folder_path = "./docs/.open-next"
  }]

  website_bucket = {
    force_destroy = true
  }
}