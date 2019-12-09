resource "aws_route53_record" "rsync" {
  zone_id = "${var.zone_id}"
  name    = "rsync"
  type    = "A"
  ttl     = "5"
  records = ["${aws_instance.rsync.public_ip}"]
}
