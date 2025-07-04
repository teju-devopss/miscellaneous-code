terraform {
  backend "s3" {
    bucket = "teju-devops"
    key    = "miscellaneous/all/terraform.tfstate"
    region = "us-east-1"
  }
}