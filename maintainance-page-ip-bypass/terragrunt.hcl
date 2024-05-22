locals {
  ip_addresses = yamldecode(file("${path_relative_from_include()}/ip_addresses.yaml"))
}

terraform {
  source          = "tfr://registry.terraform.io/RJPearson94/open-next/aws//modules/tf-aws-open-next-zone?version=3.0.0"
  include_in_copy = ["./.open-next"]
}

inputs = {
  prefix = "open-next-auth-${get_aws_account_id()}"
  folder_path = "./.open-next"
  s3_exclusion_regex = ".*\\.terragrunt*"

  website_bucket = {
    force_destroy = true
  }

  waf = {
    deployment = "CREATE"
    aws_managed_rules = []
    additional_rules = [{
      enabled = true
      name = "maintainance"
      action = "BLOCK"
      block_action = {
        response_code = 503
        custom_response_body_key = "maintainance"
      }
      ip_address_restrictions = [{
        action = "BYPASS"
        name = "ivp4_bypass"
      },{
        action = "BYPASS"
        name = "ivp6_bypass"
      }]
    }]
    custom_response_bodies = [{
      key = "maintainance"
      content = file("./static/503.html")
      content_type = "TEXT_HTML"
    }]
    ip_addresses = {
      "ivp4_bypass": {
        ip_address_version = "IPV4"
        addresses = local.ip_addresses["ipv4_addresses"]
      },
      "ivp6_bypass": {
        ip_address_version = "IPV6"
        addresses = local.ip_addresses["ipv6_addresses"]
      }
    }
  }
}