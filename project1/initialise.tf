provider "aws" {
  version = "~>4.39.0"
  region  = "eu-west-2"
}

provider "template" {
  version = "~> 2.1"
}

provider "random" {
  version = "~> 2.2"
}

terraform {
  required_version = "1.2.5"
}