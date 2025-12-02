resource "aws_security_group" "vpc_default" {
    count = var.create_default_security_group ? 1 : 0
    name = "${local.name}-vpc-sg"
    vpc_id = aws_vpc.vpc.id
    description = "VPC-wide SG: allow intra-vpc traffic and all outbound"

    # Allow inbound from same sg
    ingress {
        description = "intra vpc"
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }

    egress {
        description = "all outbound"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(local.common_tags, {
        Name = "${local.name}-vpc-sg"
    })
}