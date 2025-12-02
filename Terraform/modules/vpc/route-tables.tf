# public route table + route to igw
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.vpc.id

    tags = merge(local.common_tags, {
        Name = "${local.name}-public-rt"
    })
}

resource "aws_route" "public_internet_access" {
    route_table_id         = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assec" {
    count = length(aws_subnet.public)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id  
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.vpc.id  

    tags = merge(local.common_tags, {
        Name = "${local.name}-private-rt"
    })
}

# If NAT enabled add a 0.0.0.0/0 route to the NAT gateway in the same AZ
resource "aws_route" "private_to_nat" {
    count = var.enable_nat ? 1 : 0
    
    route_table_id = aws_route_table.private.id
    destination_cidr_block = "0.0.0.0/0"

    nat_gateway_id = var.enable_nat && length(aws_nat_gateway.nat) > 0 ? aws_nat_gateway.nat[0].id : null

    depends_on = [ aws_nat_gateway.nat, aws_internet_gateway.igw ]
}

# Associate private nat route tables to private subnet
resource "aws_route_table_association" "private_assoc" {
    count = length(aws_subnet.private)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id

}