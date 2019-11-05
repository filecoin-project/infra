resource "aws_instance" "rsync" {
  count         = 1
  ami           = "ami-05dd872834847c880"
  instance_type = "c5.2xlarge"
  key_name      = "${var.aws_key_pair}"

  iam_instance_profile = "${aws_iam_instance_profile.rsync.name}"

  vpc_security_group_ids = [
    "${aws_security_group.trusted-setup-runner.id}",
  ]

  root_block_device {
    volume_type = "gp2"
    volume_size = 1000
  }

  tags {
    Terraform = "yes"
    Name      = "rsync-${count.index}"
  }
}

resource "aws_iam_role" "rsync" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "rsync" {
  role = "${aws_iam_role.rsync.name}"
}

data "aws_s3_bucket" "trusted_setup" {
  bucket = "trusted-setup"
}

data "aws_iam_policy_document" "full_s3_access_trusted_setup" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "${data.aws_s3_bucket.trusted_setup.arn}"
    ]
  }
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "${data.aws_s3_bucket.trusted_setup.arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "policy" {
  role   = "${aws_iam_role.rsync.id}"
  policy = "${data.aws_iam_policy_document.full_s3_access_trusted_setup.json}"
}
