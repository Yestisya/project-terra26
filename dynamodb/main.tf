provider "aws" {
  region = var.aws_region
}

resource "aws_dynamodb_table" "terra_table" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "project-terra26-table"
    Environment = "dev"
  }
}
