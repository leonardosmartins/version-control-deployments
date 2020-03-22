terraform {
  backend "s3" {
    bucket = "version-control-deployments.leonardo.poc"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}
