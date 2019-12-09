resource "aws_s3_bucket" "trusted_setup_ap" {
  provider = "aws.ap"
  bucket   = "trusted-setup-ap"

  versioning {
    enabled = true
  }

}

resource "aws_s3_bucket_policy" "trusted_setup_ap" {
  provider = "aws.ap"
  bucket   = "${aws_s3_bucket.trusted_setup_ap.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicGetObjects",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::trusted-setup-ap/*"
        },
        {
            "Sid": "PublicListBucket",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::trusted-setup-ap"
        }
    ]
}
POLICY
}
