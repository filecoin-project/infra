resource "aws_s3_bucket" "trusted_setup" {
  bucket = "trusted-setup"

  versioning {
    enabled = true
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
