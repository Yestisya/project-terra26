variable "aws_region" {
  description = "Region AWS"
  default     = "ap-southeast-1"
}

variable "vpc_id" {
  description = "VPC yang sudah ada"
  default     = "vpc-06f43c2f9a1247823"
}

variable "subnet_id" {
  description = "Subnet di dalam VPC"
  default     = "subnet-0e9e618ed879cbc1c"
}

variable "key_name" {
  description = "Key pair untuk SSH"
  default     = "project-terra26-key"
}

variable "instance_type" {
  description = "Tipe EC2"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI Ubuntu 22.04 LTS"
  default     = "ami-0a23fccf7e01e8d24"  #ap-southeast-1
}