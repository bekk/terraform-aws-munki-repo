terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      configuration_aliases = [
        aws.acm,
      ]
      version = "~> 4.23"
    }
  }
}

provider "aws" {
  alias   = "use1"
  region  = "us-east-1"
}

