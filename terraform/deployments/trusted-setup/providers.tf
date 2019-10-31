provider "packet" {
  auth_token = "${var.packet_auth_token}"
}

terraform {
  backend "s3" {
    bucket         = "filecoin-terraform-state"
    key            = "trusted-setup-us-east-1.tfstate"
    dynamodb_table = "filecoin-terraform-state"
    region         = "us-east-1"
    profile        = "filecoin"
  }
}
