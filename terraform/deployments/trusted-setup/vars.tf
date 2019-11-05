variable "project_id" {
  description = "packet project id"
  default     = ""
}

variable "compute_public_key" {}
variable "subnet_id" {}

variable "packet_auth_token" {
  description = "packet api token"
}

variable "aws_region" {
  description = "aws region"
  default     = "eu-central-1"
}

variable "aws_key_pair" {
  description = "ec2 key pair name"
}
