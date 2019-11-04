resource "packet_device" "ams1_m2" {
  count               = 1
  hostname            = "trusted-setup-m2-${count.index}"
  plan                = "m2.xlarge.x86"
  facilities          = ["ams1"]
  operating_system    = "ubuntu_18_04"
  billing_cycle       = "hourly"
  project_id          = "${var.project_id}"
  project_ssh_key_ids = ["${values(local.ssh_keys)}"]
}

locals {
  ssh_keys {
    infra = "18698f2c-0ed6-45ae-9189-36b12c480da5"
  }
}

resource "aws_security_group" "trusted-setup-runner" {
  name        = "stats_backend_nightly"
  description = "Stats backend security group."

  # vpc_id      = "${var.vpc_id}"

  # allow ssh
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "trusted-setup-runner" {
  count         = 1
  ami           = "ami-05dd872834847c880"
  instance_type = "c5.24xlarge"
  key_name      = "${var.aws_key_pair}"

  vpc_security_group_ids = [
    "${aws_security_group.trusted-setup-runner.id}",
  ]

  tags {
    Terraform = "yes"
    Name      = "trusted-setup-runner-${count.index}"
  }
}

resource "aws_ebs_volume" "trusted_setup_runner" {
  count             = 1
  availability_zone = "${var.aws_region}c"
  size              = "5000"
  type              = "gp2"

  tags = {
    Name = "trusted-setup-${count.index}"
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes  = ["aws_instance.trusted-setup-runner"]
  }
}

resource "aws_volume_attachment" "trusted_setup_runner" {
  device_name  = "/dev/sdh"
  volume_id    = "${aws_ebs_volume.trusted_setup_runner.id}"
  instance_id  = "${aws_instance.trusted-setup-runner.id}"
  force_detach = false
}
