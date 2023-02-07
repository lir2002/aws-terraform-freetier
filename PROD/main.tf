terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"
}

data "aws_key_pair" "East2" {
  key_name           = "East2ED25519"
  include_public_key = true
}

resource "aws_instance" "app_server" {
  ami           = "ami-05bfbece1ed5beb54"
  instance_type = "t2.micro"

  tags = {
    Name = "tfAmi-PROD"
  }

  key_name = data.aws_key_pair.East2.key_name

  vpc_security_group_ids = ["sg-0ef47b71cfc237432"]

  subnet_id = "subnet-0e0912d034db7f4fc"

  private_ip = "172.31.38.23"
}
