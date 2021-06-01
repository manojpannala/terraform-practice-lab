terraform {
  backend "s3-bucket" {
      bucket = "tf-state-1994"
      key = "development/terraform_state"
      region = "eu-central-1"
  }
}