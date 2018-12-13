provider "vault" {}

resource "tfe_sentinel_policy" "instance_type" {
  name = "instance-size-test"
  organization = "${var.organization}"
  policy = "${file("${path.module}/../instance_type.sentinel.tpl")}"
  enforce_mode = "hard-mandatory"
}

resource "tfe_workspace" "test_pass" {
  name = "instance-size-test-pass"
  organization = "${var.organization}"
  auto_apply = true
}

resource "tfe_variable" "AWS_ACCESS_KEY_ID_pass" {
  key = "AWS_ACCESS_KEY_ID"
  value = "${data.vault_aws_access_credentials.creds.access_key}"
  category = "env"
  workspace_id = "${tfe_workspace.test_pass.id}"
}

resource "tfe_variable" "AWS_SECRET_ACCESS_KEY_pass" {
  key = "AWS_SECRET_ACCESS_KEY"
  value = "${data.vault_aws_access_credentials.creds.secret_key}"
  category = "env"
  workspace_id = "${tfe_workspace.test_pass.id}"
  sensitive = true
}

resource "tfe_variable" "AWS_DEFAULT_REGION_pass" {
  key = "AWS_DEFAULT_REGION"
  value = "${var.aws_default_region}"
  category = "env"
  workspace_id = "${tfe_workspace.test_pass.id}"
  sensitive = true
}

resource "tfe_workspace" "test_fail" {
  name = "instance-size-test-fail"
  organization = "${var.organization}"
  auto_apply = true
}

resource "tfe_variable" "AWS_ACCESS_KEY_ID_fail" {
  key = "AWS_ACCESS_KEY_ID"
  value = "${data.vault_aws_access_credentials.creds.access_key}"
  category = "env"
  workspace_id = "${tfe_workspace.test_fail.id}"
}

resource "tfe_variable" "AWS_SECRET_ACCESS_KEY_fail" {
  key = "AWS_SECRET_ACCESS_KEY"
  value = "${data.vault_aws_access_credentials.creds.secret_key}"
  category = "env"
  workspace_id = "${tfe_workspace.test_fail.id}"
  sensitive = true
}

resource "tfe_variable" "AWS_DEFAULT_REGION_fail" {
  key = "AWS_DEFAULT_REGION"
  value = "${var.aws_default_region}"
  category = "env"
  workspace_id = "${tfe_workspace.test_fail.id}"
  sensitive = true
}

resource "tfe_policy_set" "test" {
  name = "instance-size-test"
  description = "Testing instance-size"
  organization = "${var.organization}"
  policy_ids = ["${tfe_sentinel_policy.instance_type.id}"]
  depends_on = [
    "tfe_workspace.test_fail",
    "tfe_workspace.test_pass"
  ]
  workspace_external_ids = ["${tfe_workspace.test_pass.external_id}", "${tfe_workspace.test_fail.external_id}"]
}