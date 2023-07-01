terraform {
  source          = "tfr://registry.terraform.io/RJPearson94/open-next/aws?version=1.2.0"
  include_in_copy = ["./docs/.open-next", "./home/.open-next"]
}

inputs = {
  prefix = "open-next-mz-${get_aws_account_id()}"
  open_next = {
    exclusion_regex  = ".*\\.terragrunt*"
    root_folder_path = "./home/.open-next"
    additional_zones = [{
      name = "docs"
      http_path = "docs"
      folder_path = "./docs/.open-next"
    }]
  }
}