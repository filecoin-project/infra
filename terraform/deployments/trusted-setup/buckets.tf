resource "aws_s3_bucket" "trusted_setup" {
  bucket = "trusted-setup"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${aws_s3_bucket.trusted_setup_logs.id}"
    target_prefix = "trusted-setup-logs/"
  }
}

resource "aws_s3_bucket_policy" "trusted_setup" {
  bucket = "${aws_s3_bucket.trusted_setup.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "Policy1572638171339",
    "Statement": [
        {
            "Sid": "Stmt1572637929183",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::trusted-setup/*"
        },
        {
            "Sid": "Stmt1572638169062",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::trusted-setup"
        }
    ]
}
POLICY
}

resource "aws_s3_bucket" "trusted_setup_logs" {
  bucket = "trusted-setup-logs"
  acl    = "log-delivery-write"
}
