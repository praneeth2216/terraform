terraform {
  required_providers {
    aws = { 
       source = "hashicorp/aws"
       version = "~> 3.0" 
    }
  } 

 backend "s3" {
  bucket = "tf-state-terraform"
  key = "state/terraform.tfstate"
  dynamodb_table="terraform-locks"
  encrypt = true  
 } 

}   

provider "aws" {
  region = "us-east-2"
} 

resource "aws_instance" "devops" {
   ami = "ami-09786574678"
   instance_type = "t3.micro"
   key_name = "terraform"

   tags = {
    Name = "devops"
    Environment = "dev"
    } 
} 