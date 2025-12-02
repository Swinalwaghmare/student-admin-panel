variable "project_name" {
    type        = string
    description = "Project name used for tagging"
}

variable "environment" {
    type        = string
    description = "Environment name (dev/stg/prod)"
}

variable "vpc_id" {
    type        = string
    description = "VPC id where security group will be created"
}

variable "allowed_ssh_cidrs" {
    type = list(string)
    description = "CIDR ranges allowed SSH to bastion (recommend single IP/range)"
    default = [ "0.0.0.0/0" ]
}

variable "allowed_egress_cidrs" {
    type = list(string)
    description = "CIDR ranges allowed for outbound (egress) from SGs. Narrow in production."
    default = [ "0.0.0.0/0" ]
}

variable "frontend_app_port" {
    type = number
    description = "Port frontend application listens on (target group port)"
    default = 80
}

variable "backend_app_port" {
    type = number
    description = "Port backend application listens on"
    default = 8080
}

variable "rds_port" {
    type = number
    description = "Port for RDS (mysql)"
    default = 0  
}

variable "extra_tags" {
    type = map(string)
    description = "Additional tags to apply"
    default = {}
}