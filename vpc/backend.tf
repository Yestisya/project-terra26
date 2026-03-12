terraform {
  backend "s3" {
    bucket         = "project-terra26"
    key            = "vpc/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "project-terra26-lock"
    encrypt        = true
  }
}