resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = var.app_name
  }
}

resource "aws_subnet" "public" {
  count                   = var.pub-sb-count
  cidr_block              = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, 2 + count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id                  = aws_vpc.main_vpc.id
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.app_name}-Public-Subnet"
  }
}

resource "aws_subnet" "private" {
  count             = var.priv-sb-count
  cidr_block        = cidrsubnet(aws_vpc.main_vpc.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id            = aws_vpc.main_vpc.id
   
  tags = {
    Name = "${var.app_name}-Private-Subnet"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main_vpc.id

    tags = {
    Name = "${var.app_name}-IG"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.app_name}-Public-Route-Table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "${var.app_name}-Private-Route-Table"
  }
}

resource "aws_route_table_association" "public-route-ass" {
    count = var.pub-sb-count
  route_table_id = element(aws_route_table.public.*.id, count.index) 
  subnet_id = element(aws_subnet.public.*.id, count.index)
}

resource "aws_route_table_association" "private-route-ass" {
     count = var.priv-sb-count
  route_table_id = element(aws_route_table.private.*.id, count.index)
  subnet_id = element(aws_subnet.private.*.id, count.index)
}
