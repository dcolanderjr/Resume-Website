
terraform {
  required_version = "= 1.5.2"
}

provider "aws" {
    region = "us-east-1"
}

module "locals" {
    source = "./locals"
}
