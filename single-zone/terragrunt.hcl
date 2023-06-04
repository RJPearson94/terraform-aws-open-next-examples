terraform {
  source          = "tfr://registry.terraform.io/RJPearson94/open-next/aws?version=1.0.2"
  include_in_copy = ["./.open-next"]
}

inputs = {
  prefix = "open-next-sz-${get_aws_account_id()}"
  open_next = {
    exclusion_regex  = ".*\\.terragrunt-source-manifest"
    root_folder_path = "./.open-next"
  }
}