terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "SentinelTesting"
    workspaces {
      name = "instance-size-test-pass"
    }
  }
}
