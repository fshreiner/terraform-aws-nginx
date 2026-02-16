terraform {
  backend "s3" {
    bucket         = "terraform-states-fshreiner"
    key            = "foundation/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}