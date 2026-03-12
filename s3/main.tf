provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "terra_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "project-terra26"
    Environment = "dev"
  }
}
