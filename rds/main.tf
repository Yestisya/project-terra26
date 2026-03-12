provider "aws" {
  region = var.aws_region
}

# -------------------------
# SECURITY GROUP RDS
# -------------------------
resource "aws_security_group" "postgres_sg" {
  name   = "${var.project_name}-postgres-sg"
  vpc_id = var.vpc_id

  description = "Security group for PostgreSQL RDS in private subnet"

  ingress {
    description = "Allow PostgreSQL access from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-postgres-sg"
  }
}

# -------------------------
# DB SUBNET GROUP
# -------------------------
resource "aws_db_subnet_group" "postgres_subnet_group" {
  name       = "${var.project_name}-postgres-subnet"
  subnet_ids = [var.private_subnet_a, var.private_subnet_b]

  tags = {
    Name = "${var.project_name}-postgres-subnet"
  }
}

# -------------------------
# RDS POSTGRESQL
# -------------------------
resource "aws_db_instance" "postgres_db" {
  identifier = "${var.project_name}-rds"

  engine         = "postgres"
  engine_version = "15"

  instance_class    = "db.t3.micro"
  allocated_storage = 20

  username = var.db_username
  password = var.db_password
  port     = 5432

  db_subnet_group_name   = aws_db_subnet_group.postgres_subnet_group.name
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Name = "${var.project_name}-rds"
  }
}