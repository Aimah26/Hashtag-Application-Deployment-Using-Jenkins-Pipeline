#create backend s3 bucket
resource "aws_s3_bucket" "jas-bucket" {
  bucket        = "jas-bucket"
  force_destroy = true
  tags = {
    Name = "jas-bucket"
  }
}

# Creating the backend S3 Bucket acl
resource "aws_s3_bucket_acl" "jas-bucket-acl" {
  bucket = aws_s3_bucket.jas-bucket.id
  acl    = "private"
}

#create Dynamodb table
resource "aws_dynamodb_table" "jas-lock" {
  name     = "jas-dynamo-table"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  write_capacity = 1
  read_capacity  = 1

  tags = {
    Name        = "TF state Lock"
    Environment = "Terraform"
  }
}