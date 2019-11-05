variable "project_id" {
  description = "packet project id"
  default     = ""
}

variable "compute_public_key" {
  description = "public key for the compute instance to talk to the rsyncbox"
}

# TODO migrate this subnet to terraform
variable "subnet_id" {
  description = "subnet_id the compute instance is on"
}

variable "zone_id" {
  description = "zone_id to create the rsync record under"
}

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
