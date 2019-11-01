output "public_ips_ams1_m2" {
  value = "${packet_device.ams1_m2.*.access_public_ipv4}"
}

output "public_ips_aws" {
  value = "${aws_instance.trusted-setup-runner.*.public_ip}"
}
