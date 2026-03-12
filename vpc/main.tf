provider "aws" {
  region = var.aws_region
}

# -------------------------
# VPC
# -------------------------

resource "aws_vpc" "project_terra26_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "project-terra26-vpc"
  }
}

# -------------------------
# INTERNET GATEWAY
# -------------------------

resource "aws_internet_gateway" "project_terra26_igw" {
  vpc_id = aws_vpc.project_terra26_vpc.id

  tags = {
    Name = "project-terra26-igw"
  }
}

# -------------------------
# PUBLIC SUBNET
# -------------------------

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.project_terra26_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "terra26-public-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.project_terra26_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "terra26-public-b"
  }
}

# -------------------------
# PRIVATE SUBNET
# -------------------------

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.project_terra26_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "terra26-private-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.project_terra26_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "terra26-private-b"
  }
}

# -------------------------
# PUBLIC ROUTE TABLE
# -------------------------

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.project_terra26_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_terra26_igw.id
  }

  tags = {
    Name = "terra26-public-rt"
  }
}

resource "aws_route_table_association" "public_a_assoc" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_b_assoc" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rt.id
}

# -------------------------
# ELASTIC IP FOR NAT
# -------------------------

resource "aws_eip" "terra26_nat_eip" {
  domain = "vpc"

  tags = {
    Name = "terra26-nat-eip"
  }
}

# -------------------------
# NAT GATEWAY
# -------------------------

resource "aws_nat_gateway" "terra26_nat" {
  allocation_id = aws_eip.terra26_nat_eip.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "terra26-nat-gateway"
  }

  depends_on = [aws_internet_gateway.project_terra26_igw]
}

# -------------------------
# PRIVATE ROUTE TABLE
# -------------------------

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.project_terra26_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terra26_nat.id
  }

  tags = {
    Name = "terra26-private-rt"
  }
}

resource "aws_route_table_association" "private_a_assoc" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_b_assoc" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_rt.id
}