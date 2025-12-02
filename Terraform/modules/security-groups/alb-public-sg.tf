resource "aws_security_group" "alb_public" {
    name = "${local.name_prefix}-alb-public-sg"
    description = "Public ALB - allows HTTP/HTTPS from Internet"
    vpc_id = var.vpc_id

    ingress {
        description = "HTTP from anywhere"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        description = "HTTPS from anywhere"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.allowed_egress_cidrs
    }

    tags = merge(local.common_tags, {
        Name = "${local.name_prefix}-alb-public-sg"
    })
}