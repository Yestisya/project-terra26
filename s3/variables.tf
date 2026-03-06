variable "aws_region" {
  description = "AWS Region"
  default     = "ap-southeast-1"
}

variable "bucket_name" {
  description = "Name of S3 bucket"
  type        = string
}
