terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }
  cloud {
    organization = "AWS-practice-kazu-man"
    workspaces {
      name = "aws-infra"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_subnet" "test_subnet" {
  vpc_id                  = "vpc-f2595d95"
  cidr_block              = "172.31.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "TestSubnet"
  }
}

resource "aws_instance" "test_server" {
  ami           = "ami-0eba6c58b7918d3a1"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.test_subnet.id

  tags = {
    Name      = "TestInstance",
    ManagedBy = "HCP Terraform"
  }
}