variable "server_id" {}
variable "role" {}
variable "bucket" {}
variable "user_name" {}
variable "public_key" {}


resource "aws_transfer_user" "this" {
  server_id = "${var.server_id}"
  user_name = "${var.user_name}"
  role      = "${var.role}"
  home_directory = "/${var.bucket}/${var.user_name}"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowListingOfUserFolder",
            "Action": [
                "s3:ListBucket"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::$${transfer:HomeBucket}"
            ],
            "Condition": {
                "StringLike": {
                    "s3:prefix": [
                        "$${transfer:UserName}/*",
                        "$${transfer:UserName}"
                    ]
                }
            }
        },
        {
            "Sid": "HomeDirObjectAccess",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::$${transfer:HomeDirectory}*"
        }
    ]
}
POLICY
}

resource "aws_transfer_ssh_key" "this" {
  server_id = "${var.server_id}"
  user_name = "${aws_transfer_user.this.user_name}"
  body      = "${var.public_key}"
}

