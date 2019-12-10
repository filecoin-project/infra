output "public_ips_ams1_m2" {
  value = "${packet_device.ams1_m2.*.access_public_ipv4}"
}

output "public_ips_aws" {
  value = "${aws_instance.trusted-setup-runner.*.public_ip}"
}

output "public_ips_x1" {
  value = "${aws_instance.trusted_setup_runner_x1.*.public_ip}"
}

output "public_ips_rsync" {
  value = "${aws_instance.rsync.*.public_ip}"
}
