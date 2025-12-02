resource "aws_security_group" "rds" {
    name = "${local.name_prefix}-rds-sg"
    description = "RDS SG - only allow DB connection from backend EC2 SG"
    vpc_id = var.vpc_id
    
    # Ingress only from backend EC2 SG
    ingress {
        description = "MySQL access from backend"
        from_port = var.rds_port
        to_port = var.rds_port
        protocol = "tcp"
        security_groups = [aws_security_group.backend.id]
    }

    # optional: allow access from bastion for admin/debug (comment out if not needed)
    ingress {
        description = "MySQL admin from bastion"
        from_port = var.rds_port
        to_port = var.rds_port
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
        Name = "${local.name_prefix}-rds-sg"
    })
}