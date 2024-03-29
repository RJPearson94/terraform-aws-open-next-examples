terraform {
  source          = "tfr://registry.terraform.io/RJPearson94/open-next/aws//modules/legacy?version=2.3.0"
  include_in_copy = ["./.open-next"]
}

inputs = {
  prefix = "open-next-legacy-${get_aws_account_id()}"
  open_next = {
    exclusion_regex  = ".*\\.terragrunt*"
    root_folder_path = "./.open-next"
  }
}