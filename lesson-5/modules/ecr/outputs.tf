# lesson-5/modules/ecr/outputs.tf

output "repository_url" {
    description = "URL of the ECR repository for Docker images"
    value       = aws_ecr_repository.this.repository_url
}  

