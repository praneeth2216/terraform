terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "karupothula2"
    key = "state/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table="terraform-locks"
    encrypt = true
  }
}


provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "powershell" {
  ami = "ami-0ca4d5db4872d0c28"
  instance_type = "t3.micro"
  key_name = "terraform"

  tags = {
    Name = "powershell"
    Environment = "dev"
  }
}

resource "aws_instance" "shell" {
  ami = "ami-0ca4d5db4872d0c28"
  instance_type = "t3.micro"
  key_name = "terraform"
  tags = {
    Name = "shell"
    Environment = "dev"
  }
}
