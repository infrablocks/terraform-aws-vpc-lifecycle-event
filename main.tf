locals {
  vpc_lifecycle_event_key = "vpc-existence/${var.vpc_account_id}/${var.vpc_id}"
}

resource "aws_s3_bucket_object" "vpc_lifecycle_event" {
  bucket = var.infrastructure_events_bucket
  key = local.vpc_lifecycle_event_key
  content = var.vpc_id
}
