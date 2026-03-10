provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "project_terra26_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "project-terra26-vpc"
  }
}

resource "aws_subnet" "project_terra26_subnet" {
  vpc_id            = aws_vpc.project_terra26_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.az

  tags = {
    Name = "project-terra26-subnet"
  }
}

resource "aws_internet_gateway" "project_terra26_igw" {
  vpc_id = aws_vpc.project_terra26_vpc.id

  tags = {
    Name = "project-terra26-igw"
  }
}