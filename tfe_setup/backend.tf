terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "SentinelTesting"
    workspaces {
      name = "PolicyCreation"
    }
  }
}
