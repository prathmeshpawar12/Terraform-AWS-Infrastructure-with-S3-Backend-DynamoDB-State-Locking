resource "aws_s3_bucket" "terraform_state" {
  bucket = "my-terraform-state-bucket-12345"

  tags = {
    Name = "Terraform State Bucket"
  }
}