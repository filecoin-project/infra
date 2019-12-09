resource "aws_instance" "rsync" {
  count         = 1
  ami           = "ami-05dd872834847c880"
  instance_type = "c5.2xlarge"
  key_name      = "${var.aws_key_pair}"
  subnet_id     = "${data.aws_subnet.subnet.id}"
  user_data     = "${data.template_file.user_data.rendered}"

  vpc_security_group_ids = [
    "${aws_security_group.trusted-setup-runner.id}",
  ]

  root_block_device {
    volume_type = "gp2"
    volume_size = 2000
  }

  tags {
    Terraform = "yes"
    Name      = "rsync-${count.index}"
  }
}

data "template_file" "user_data" {
  template = "${file("./templates/user_data.rsyncbox.bash.tmpl")}"

  vars {
    compute_public_key = "${var.compute_public_key}"
  }
}
