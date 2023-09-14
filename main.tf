terraform {
   backend "pg" {}
}


provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_key_pair" "student-key" {
  key_name   = "student-key"
  public_key = file("id_rsa.pub")
}


resource "aws_instance" "app_server" {
  ami           = "ami-0bee6b4258f1faee4"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg-appserv.id]
  key_name = "student-key"
  provisioner "local-exec" {
    command = <<EOT
       sleep 30;
    EOT
  }
}

resource "aws_security_group" "sg-appserv" {
  name        = "sg_appserv"
  description = "AppServ Security Group"
  ingress {
    description      = "SSH Access"
    from_port        = 0
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP Access"
    from_port        = 0
    to_port          = 80
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
    Name = "allow_appserv"
  }
}

