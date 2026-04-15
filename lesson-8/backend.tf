# # /lesson-8/backend.tf

# terraform {
#   backend "s3" {
#     bucket         = "lesson-8-jenkins-state-bucket-001001"# Назва S3-бакета
#     key            = "lesson-8/terraform.tfstate"   # Шлях до файлу стейту
#     region         = "eu-west-1"                    # Регіон AWS
#     dynamodb_table = "terraform-locks-jenkins"      # Назва таблиці DynamoDB
#     encrypt        = true                           # Шифрування файлу стейту
#   }
# }
