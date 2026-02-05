terraform {
  backend "s3" {
    bucket         = "terraform-states-fshreiner"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}