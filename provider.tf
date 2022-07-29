terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.23"
    }
  }
}

provider "aws" {
  alias   = "use1"
  region  = "us-east-1"
}
provider "aws" {
  alias = "acm"
  version = "~> 4.23"
}
