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
