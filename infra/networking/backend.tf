terraform {
  required_version = ">= 0.12.31"

  backend "s3" {
    bucket = "ncloud-gblog-proj-global-states"
    key    = "networking/terraform.tfstate"
    region = "eu-west-1"
  }
}