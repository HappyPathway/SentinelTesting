variable "aws_vars" {
    default = false
    description = "Flag for setting AWS Environment Variables"
}

variable "aws_default_region" {
  default = "us-east-1"
}

variable "aws_role" {
  default = "ec2_admin"
  type = "string"
  description = "Vault AWS Dynamic Secrets Role"
}
data "vault_aws_access_credentials" "creds" {
    backend = "aws"
    role    = "${var.aws_role}"
}

