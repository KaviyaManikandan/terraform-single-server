provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0fb653ca2d3203ac1"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id     = "subnet-00dfb4d67ac08ffbe"  # Specify your subnet ID here
  user_data = <<-EOF
    #!/bin/bash
    echo "Hii kaviya" > index.html
    nohup busybox httpd -f -p 80 &
    EOF

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "sg" {
  name = "terraform-example-instance"
  vpc_id = "vpc-0a4318010bc59a847"  # Specify your VPC ID here

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
