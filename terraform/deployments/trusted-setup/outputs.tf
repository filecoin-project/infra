output "public_ips_ams1_m2" {
  value = "${packet_device.ams1_m2.*.access_public_ipv4}"
}
