resource "aws_security_group" "bastion" {
    name        = "${local.name_prefix}-bastion-sg"
    description = "Bastion host SG - allow SSH from allowed CIDRs"
    vpc_id      = var.vpc_id
    
    ingress {
        description = "SSH from allowed CIDRs"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = var.allowed_ssh_cidrs
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = var.allowed_egress_cidrs
    }

    tags = merge(local.common_tags, {
        Name = "${local.name_prefix}-bastion-sg"
    })
}