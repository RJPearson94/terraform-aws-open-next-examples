locals {
  prefix = var.prefix == null ? "" : "${var.prefix}-"
  suffix = var.suffix == null ? "" : "-${var.suffix}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${local.prefix}vpc${local.suffix}"
  cidr = var.cidr_range

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  single_nat_gateway = true

  # DNS settings
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# Create a security group for Lambda functions
resource "aws_security_group" "lambda_sg" {
  vpc_id = module.vpc.vpc_id

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

# Security Group for VPC Endpoint resources
resource "aws_security_group" "vpc_endpoint_sg" {
  vpc_id = module.vpc.vpc_id

  # Allow inbound HTTPS traffic from Lambda's security group
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.lambda_sg.id]
  }
}

# Create a VPC endpoint for Dynamodb, S3 & SQS to allow Lambda to access it without going through the internet
resource "aws_vpc_endpoint" "vpc_endpoint" {
  for_each = { "dynamodb" = "Gateway", "s3" = "Gateway", "sqs" = "Interface" }

  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.${each.key}"
  vpc_endpoint_type   = each.value
  subnet_ids          = each.value == "Interface" ? module.vpc.private_subnets : null
  security_group_ids  = each.value == "Interface" ? [aws_security_group.vpc_endpoint_sg.id] : null
  private_dns_enabled = each.value == "Interface" ? true : null
  route_table_ids     = each.value == "Gateway" ? module.vpc.private_route_table_ids : null
}

module "opennext_single_zone" {
  source  = "RJPearson94/open-next/aws//modules/tf-aws-open-next-zone"
  version = "3.3.0"

  open_next_version = "v3.x.x"
  folder_path       = "./.open-next"

  prefix = var.prefix
  suffix = var.suffix

  server_function = {
    vpc = {
      security_group_ids = [aws_security_group.lambda_sg.id]
      subnet_ids         = module.vpc.private_subnets
    }
  }

  distribution = {
    cache_policy = {
      enable_accept_encoding_brotli = true
      enable_accept_encoding_gzip   = true
    }
  }

  website_bucket = {
    force_destroy = true
  }

  providers = {
    aws.server_function = aws.server_function
    aws.iam             = aws.iam
    aws.dns             = aws.dns
    aws.global          = aws.global
  }
}
