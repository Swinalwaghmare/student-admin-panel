resource "aws_security_group" "alb_internal" {
    name = "${local.name_prefix}-alb-internal-sg"
    description = "Internal ALB - allows traffic from within VPC or specific sources"
    vpc_id = var.vpc_id

    # Allow HTTP from Inside VPC (you could tighten to specific CIDRs)
    ingress {
        description = "HTTP from inside VPC"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/8"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.allowed_egress_cidrs
    }

    tags = merge(local.common_tags,{
        Name = "${local.name_prefix}-alb-internal-sg"
    })
}