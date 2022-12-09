resource "aws_vpc" "target" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_s3_bucket" "target" {
  bucket = "infrablocks-open-source-${var.deployment_identifier}"
  force_destroy = true
}
