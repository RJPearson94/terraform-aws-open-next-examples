variable "prefix" {
  description = "A prefix which will be attached to the resource name to ensure resources are random"
  type        = string
  default     = null
}

variable "suffix" {
  description = "A suffix which will be attached to the resource name to ensure resources are random"
  type        = string
  default     = null
}

variable "cidr_range" {
  description = "The CIDR range for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnet CIDR blocks"
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnet CIDR blocks"
  type        = list(string)
}