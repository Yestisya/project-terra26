variable "aws_region" {
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "table_name" {
  description = "DynamoDB table name"
  type        = string
}
