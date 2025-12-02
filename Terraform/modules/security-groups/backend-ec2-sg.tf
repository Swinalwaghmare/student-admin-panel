resource "aws_security_group" "backend" {
    name = "${local.name_prefix}-backend-sg"
    description = "Backend EC2 SG - accepts traffic from internal ALB or frontend instances"
    vpc_id = var.vpc_id

    # Allow app traffic from internal ALB
    ingress {
        description = "from internal ALB"
        from_port = var.backend_app_port
        to_port = var.backend_app_port
        protocol = "tcp"
        security_groups = [aws_security_group.alb_internal.id]
    }

    # Allow app traffic from frontend instances (if frontend calls backend directly)
    ingress {
        description = "from frontend instances"
        from_port = var.backend_app_port
        to_port = var.backend_app_port
        protocol = "tcp"
        security_groups = [aws_security_group.frontend.id]
    }

    # Allow SSH from bastion
    ingress {
        description = "SSH from bastion"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [aws_security_group.bastion.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.allowed_egress_cidrs
    }

    tags = merge(local.common_tags, {
        Name = "${local.name_prefix}-backend-sg"
    })
}

