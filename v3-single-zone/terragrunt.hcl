terraform {
  source          = "tfr://registry.terraform.io/RJPearson94/open-next/aws//modules/tf-aws-open-next-zone?version=3.2.0"
  include_in_copy = ["./.open-next"]
}

inputs = {
  prefix = "open-next-${get_aws_account_id()}"
  
  folder_path = "./.open-next"
  s3_exclusion_regex = ".*\\.terragrunt*"

  origin_timeouts = {
    keepalive_timeout   = 60
    read_timeout        = 60
    connection_attempts = 2
    connection_timeout  = 5
  }

  distribution = {
    cache_policy = {
      enable_accept_encoding_brotli = true
      enable_accept_encoding_gzip = true
    }
  }

  continuous_deployment = {
    use = false
    deployment = "NONE"
    traffic_config = {
      header = {
        name = "aws-cf-cd-staging"
        value = "true"
      }
    }
  }
  
  additional_server_functions = {
    iam_policies = {
      include_bucket_access             = true
      include_revalidation_queue_access = true
      include_tag_mapping_db_access     = true
    }
  }

  website_bucket = {
    force_destroy = true
  }
  open_next_version = "v3.x.x"
}