resource "tfe_sentinel_policy" "instance_type" {
  name = "instance-size"
  organization = "${var.organization}"
  policy = "${file("${path.module}/../instance_type.sentinel.tpl")}"
  enforce_mode = "hard-mandatory"
}


