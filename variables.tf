# variable is also type of block

# EC2 instance type
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# EC2 root storage size (main disk)
variable "ec2_root_storage_size" {
  description = "Root volume size for EC2 (in GB)"
  type        = number
  default     = 15
}

# EC2 AMI ID
variable "ec2_ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-0f5ee92e2d63afc18" 
}

# EC2 Name tag
variable "ec2_name" {
  description = "Name tag for EC2 instance"
  type        = string
  default     = "CWS-instance"
}

# Default root storage (for conditional expression)
variable "ec2_default_root_storage_size" {
  description = "Default root storage size if condition fails"
  type        = number
  default     = 10
}

# Environment (dev / prod)
variable "env" {
  description = "Environment type"
  type        = string
  default     = "prod"
}