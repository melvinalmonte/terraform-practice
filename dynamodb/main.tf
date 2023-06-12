provider "aws" {
  region = "us-east-1"
}

resource "random_pet" "this" {
  length = 2
}

resource "aws_kms_key" "dynamodb_key" {
  description             = "DynamoDB Encryption Key"
  deletion_window_in_days = 7
}

resource "aws_kms_key_policy" "dynamodb_policy" {
  key_id = aws_kms_key.dynamodb_key.id
  policy = jsonencode({
    Id = "custom-dynamodb-key-policy"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}

resource "aws_kms_key_policy" "dynamodb_policy" {
  key_id = aws_kms_key.dynamodb_key.id
  policy = jsonencode({
    Id = "custom-dynamodb-key-policy"
    Statement = [
      {
        Sid : "Enable IAM User Permissions",
        Effect : "Allow",
        Principal : {
          AWS : "*"
        },
        Action : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource : "*"
      },
      {
        Sid : "Allow DynamoDB Access",
        Effect : "Allow",
        Principal : {
          Service : "dynamodb.amazonaws.com"
        },
        Action : [
          "kms:Decrypt"
        ],
        Resource : "*"
      }
    ]
  })


}


module "dynamodb_table" {
  source                             = "terraform-aws-modules/dynamodb-table/aws"
  name                               = "my-table-${random_pet.this.id}"
  hash_key                           = "id"
  range_key                          = "title"
  table_class                        = "STANDARD"
  deletion_protection_enabled        = false
  server_side_encryption_enabled     = true
  server_side_encryption_kms_key_arn = aws_kms_key.dynamodb_key.arn
  billing_mode                       = "PAY_PER_REQUEST"

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "title"
      type = "S"
    },
    {
      name = "age"
      type = "N"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "TitleIndex"
      hash_key           = "title"
      range_key          = "age"
      projection_type    = "INCLUDE"
      non_key_attributes = ["id"]
    }
  ]
}


module "disabled_dynamodb_table" {
  source       = "terraform-aws-modules/dynamodb-table/aws"
  create_table = false
}

