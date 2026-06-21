# ================================
# 1. Key Pair (for EC2 login)
# ================================
resource "aws_key_pair" "my_key" {
  key_name   = "terr-key-ec2"
  public_key = file("terr-key-ec2.pub")
}

# ================================
# 2. Default VPC
# ================================
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# ================================
# 3. Security Group
# ================================
resource "aws_security_group" "my_sg" {
  name        = "automate-sg"
  description = "Terraform generated security group"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "automate-security-group"
  }

  # ---------- Inbound Rules ----------

  # SSH (Port 22)
  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP (Port 80)
  ingress {
    description = "HTTP Access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # App Port (8080)
  ingress {
    description = "App Access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ---------- Outbound Rules ----------
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ================================
# 4. EC2 Instance
# ================================
resource "aws_instance" "my_instance" {

  for_each = {
    automate-instance-micro = "t2.micro"
  }

 ami                   = ami_id = "ami-0f5ee92e2d63afc18"
instance_type          = each.value
key_name               = aws_key_pair.my_key.key_name
vpc_security_group_ids = [aws_security_group.my_sg.id]

user_data = file("install_nginx.sh")

root_block_device {
  volume_size = 8
  volume_type = "gp3"
}
  tags = {
    Name = each.key
  }
}