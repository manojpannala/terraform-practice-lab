resource "aws_iam_role" "s3-mrp-bucket-role" {
  name = "s3-mrp-bucket-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "s3-mrp-bucket-role"
  }
}

# Policy Attachment S3 Bucket Role

resource "aws_iam_role_policy" "s3-mrp-bucket-role-policy" {
  name = "s3-mrp-bucket-role-policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:*"
        Effect = "Allow"
        Sid    = ""
        Resource = [
            "arn:aws:s3:::mrp-tf-bucket-56",
            "arn:aws:s3:::mrp-tf-bucket-56/*",
        ]
        # Principal = {
        #   Service = "ec2.amazonaws.com"
        # }
      },
    ]
  })

  tags = {
    Name = "s3-mrp-bucket-role-policy"
  }
}