# Public Subnet
resource "aws_subnet" "public" {
    count                   = length(var.public_subnets)
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.public_subnets[count.index]
    availability_zone       = var.azs[count.index % length(var.azs)]
    map_public_ip_on_launch = false

    tags = merge(local.common_tags, {
        Name       = "${local.name}-public-${count.index + 1}"
        SubnetType = "public"
        AZ         = var.azs[count.index % length(var.azs)]
    })
}

# Private Subnet
resource "aws_subnet" "private" {
    count                   = length(var.private_subnets)
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = var.private_subnets[count.index]
    availability_zone       = var.azs[count.index % length(var.azs)]
    map_public_ip_on_launch = false

    tags = merge(local.common_tags, {
        Name        = "${local.name}-private-${count.index + 1}"
        SubnetType  = "private"
        AZ          = var.azs[count.index % length(var.azs) ]
    })
    
}