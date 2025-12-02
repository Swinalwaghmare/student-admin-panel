variable "project_name" {
    type        = string
    description = "Project name used for tagging"
}

variable "environment" {
    type        = string
    description = "Environment name {dev/stg/prod}"
}

variable "extra_tags" {
    type        = map(string)
    description = "Additional tags to apply to resources"
    default     = {}
}

variable "vpc_cidr" {
    type        = string
    description = "CIDR for the VPC, e.g. 10.0.0.0/16"
    default     = "10.0.0.0/16"
}

variable "azs" {
    type        = list(string)
    description = "List of availability zones to create subnets in"

    validation {
      condition = length(var.azs) >= 1
      error_message = "You must provide at least one availability zone in the 'azs' variable."
    }
}

variable "public_subnets" {
    type        = list(string)
    description = "CIDR blocks for public subnets. order must align with azs"
}

variable "private_subnets" {
    type        = list(string)
    description = "CIDR blocks for private subnets. order must align with azs"
}

variable "enable_nat" {
    type        = bool
    description = "wheather to create NAT Gateways for private subnet internet access"
    default     = true
}

variable "create_default_security_group" {
    type = bool
    description = "Create a simple VPC security group allowing intra-vpc traffic"
    default = true
}