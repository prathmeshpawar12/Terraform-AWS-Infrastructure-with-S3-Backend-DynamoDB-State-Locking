# 1. Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = "terr-key-ec2"
  public_key = file("terr-key-ec2.pub")
}

# 2. Default VPC
resource "aws_default_vpc" "default" {}

# 3. Security Group
resource "aws_security_group" "my_sg" {
  name   = "automate-sg"
  vpc_id = aws_default_vpc.default.id

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

# 4. EC2 Instance
resource "aws_instance" "my_instance" {

  ami                    = "ami-0f5ee92e2d63afc18"   # Hardcoded AMI (Mumbai)
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  user_data = file("install_nginx.sh")

  tags = {
    Name = "my-ec2-instance"
  }
}