# Create an ELASTIC IP & NAT Gateway per public az when enable_nat = true
resource "aws_eip" "nat_eip" {
    count = var.enable_nat ? 1:0
    domain = "vpc"

    tags = merge(local.common_tags, {
        Name = "${local.name}-nat-eip"
    })
}

resource "aws_nat_gateway" "nat" {
    count = var.enable_nat ? 1 : 0

    allocation_id = aws_eip.nat_eip[0].id
    subnet_id = length(aws_subnet.public)> 0 ? aws_subnet.public[0].id : null

    tags = merge(local.common_tags, {
        Name = "${local.name}-nat"
    })

    depends_on = [ aws_internet_gateway.igw ]
}

