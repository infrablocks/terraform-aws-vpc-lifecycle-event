module "vpc_lifecycle_event" {
  source = "./../../"

  vpc_id = aws_vpc.target.id
  vpc_account_id = aws_vpc.target.owner_id

  infrastructure_events_bucket = aws_s3_bucket.target.bucket
}
