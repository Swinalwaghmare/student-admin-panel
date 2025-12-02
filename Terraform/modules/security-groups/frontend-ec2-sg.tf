resource "aws_security_group" "frontend" {
    name = "${local.name_prefix}-frontend-sg"
    description = "Frontend EC2 SG"
    vpc_id = var.vpc_id

    # Allow traffic from public ALB (target group source)
    ingress {
        description = "From public ALB"
        from_port = var.frontend_app_port
        to_port = var.frontend_app_port
        protocol = "tcp"
        security_groups = [aws_security_group.alb_public.id]
    }

    # Allow SSH From bastion (optional)
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
        Name = "${local.name_prefix}-frontend-sg"
    })
}