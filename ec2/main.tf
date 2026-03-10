provider "aws" {
  region = "ap-southeast-1"
}

# Ambil AMI Ubuntu otomatis
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security Group
resource "aws_security_group" "project_terra26_sg" {
  name        = "project-terra26-sg"
  description = "Security group for project-terra26-ec2"
  vpc_id      = "vpc-06f43c2f9a1247823"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project-terra26-sg"
  }
}

# EC2 Instance
resource "aws_instance" "project_terra26_ec2" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  subnet_id                   = "subnet-0e9e618ed879cbc1c"
  vpc_security_group_ids      = [aws_security_group.project_terra26_sg.id]
  associate_public_ip_address = true

  key_name = "adrit-ec2-key"

  tags = {
    Name = "project-terra26-ec2"
  }
}