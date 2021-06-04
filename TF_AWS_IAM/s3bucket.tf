# Create S3 Bucket
resource "aws_s3_bucket" "mrp-s3bucket" {
    bucket = "mrp-tf-bucket-56"
    acl = "private"
    tags = {
      Name = "mrp-tf-bucket-56"
    }
}