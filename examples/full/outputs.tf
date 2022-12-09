output "vpc_id" {
  value = aws_vpc.target.id
}
output "vpc_account_id" {
  value = aws_vpc.target.owner_id
}
output "bucket_name" {
  value = aws_s3_bucket.target.bucket
}
output "vpc_lifecycle_event_key" {
  value = module.vpc_lifecycle_event.vpc_lifecycle_event_key
}
