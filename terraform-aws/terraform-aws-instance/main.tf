terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Provider block
provider "aws" {
  region = "us-west-2"
}

# EC2 resource block
resource "aws_instance" "web" {
  ami           = "ami-00ee4df451840fa9d" #Amazon Linux AMI
  instance_type = "t2.micro"

  security_groups = [aws_security_group.TF_SG.name]

  # AWS Keypair 1st method
  key_name = "TF_key"

  tags = {
    Name = "Terraform EC2"
  }
}

# DynamoDB resource block
# resource "aws_dynamodb_table" "tf_notes_table" {
#   name           = "tf-notes-table"
#   billing_mode   = "PROVISIONED"
#   read_capacity  = "30"
#   write_capacity = "30"
#   attribute {
#     name = "noteId"
#     type = "S"
#   }
#   hash_key = "noteId"
#   ttl {
#     enabled        = false
#     attribute_name = "expiryPeriod"
#   }
#   point_in_time_recovery { enabled = false }
#   server_side_encryption { enabled = false }
#   lifecycle { ignore_changes = ["write_capacity", "read_capacity"] }
# }
# module "table_autoscaling" {
#   source     = "snowplow-devops/dynamodb-autoscaling/aws" // add the autoscaling module
#   table_name = aws_dynamodb_table.tf_notes_table.name     // apply autoscaling for the tf_notes_table
# }

# Keypair 2nd method for Key_pair resource block
resource "aws_key_pair" "TF_key" {
  key_name   = "TF_key"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "TF-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tfkey"
}

# Security Group using Terraform resource block
resource "aws_security_group" "TF_SG" {
  name        = "security group using Terraform"
  description = "security group using Terraform"
  vpc_id      = "vpc-02386b5033fca863d"
  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "TF_SG"
  }
}

# S3 Bucket resource block
resource "aws_s3_bucket" "cerberusBucket" {
  bucket = "my-tf-cerberus-bucket09112022"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
#--------------------- Uploading single file into S3 Bucket ---------------------#
# resource "aws_s3_bucket_object" "S3SingleObject" {
#   bucket = aws_s3_bucket.cerberusBucket.id
#   key    = "home.html"
#   source = "/Users/cyrus/Desktop/pwchackathon/flask/home.html"
#   # The filemd5() function is available in Terraform 0.11.12 and later
#   # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
#   # etag = "S{md5(file("path/to/file"))}"
#   etag = filemd5("/Users/cyrus/Desktop/pwchackathon/flask/home.html")
# }
#--------------------- Uploading multiple file into S3 Bucket ---------------------#
resource "aws_s3_bucket_object" "S3MultiObject" {
  bucket   = aws_s3_bucket.cerberusBucket.id
  for_each = fileset("/Users/cyrus/Desktop/pwchackathon/flask/", "*")
  key      = each.value
  source   = "/Users/cyrus/Desktop/pwchackathon/flask/${each.value}"
  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "S{md5(file("path/to/file"))}"
  etag = filemd5("/Users/cyrus/Desktop/pwchackathon/flask/${each.value}")
}
#--------------------- Create a S3 Bucket folder ---------------------#
variable "named_folder" {
  type    = string
  default = "multiple-s3-files"
}
resource "aws_s3_bucket_object" "base_folder" {
  bucket       = aws_s3_bucket.cerberusBucket.id
  acl          = "private"
  key          = "${var.named_folder}/"
  content_type = "application/x-directory"
}
#--------------------- Uploading multiple file inside the S3 Bucket folder ---------------------#
resource "aws_s3_bucket_object" "S3Objects-inside-dir" {
  bucket   = aws_s3_bucket.cerberusBucket.id
  for_each = fileset("/Users/cyrus/Desktop/pwchackathon/data/", "*")
  key      = "${var.named_folder}/${each.value}"
  source   = "/Users/cyrus/Desktop/pwchackathon/data/${each.value}"
  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "S{md5(file("path/to/file"))}"
  etag = filemd5("/Users/cyrus/Desktop/pwchackathon/data/${each.value}")
}
