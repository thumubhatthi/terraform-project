#this file consists of code for instances and sg
provider "aws" {
region = "eu-west-3"
access_key = "AKIASGSZUTFFMFAZYLO2"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-07e67bd6b5d9fd892"
  instance_type   = "t2.micro"
  key_name        = "paris"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-west-3a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by barath sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-07e67bd6b5d9fd892"
  instance_type   = "t2.micro"
  key_name        = "paris"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-west-3b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by barath sir server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-07e67bd6b5d9fd892"
  instance_type   = "t2.micro"
  key_name        = "paris"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-west-3a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-07e67bd6b5d9fd892"
  instance_type   = "t2.micro"
  key_name        = "paris"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "eu-west-3b"
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
  name = "bhatthi-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "six" {
  bucket = "pavanbhatthi123"
}

resource "aws_iam_user" "seven" {
for_each = var.user_names
name = each.value
}

variable "user_names" {
description = "*"
type = set(string)
default = ["user2", "user3", "user4", "user5"]
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "eu-west-3a"
  size = 16
  tags = {
    Name = "ebs-bhatthi08"
  }
}
