output "kms_key" {
  description = "The KMS customer master key to encrypt state buckets."
  value       = module.remote_state.kms_key.arn
}

output "state_bucket" {
  description = "The S3 bucket to store the remote state file."
  value       = module.remote_state.state_bucket.bucket
}

output "dynamodb_table" {
  description = "The dynamodb table for state lock."
  value       = module.remote_state.dynamodb_table.name
}

output "aws_region" {
  description = "AWS region."
  value       = var.region
}