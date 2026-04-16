terraform {
  backend "s3" {
    bucket       = "terraform-states-fshreiner"
    key          = "foundation/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}