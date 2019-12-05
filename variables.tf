variable "infrastructure_events_bucket" {
  type = string
  description = "The name of the infrastructure bucket in which to put the lifecycle event."
}

variable "vpc_id" {
  type = string
  description = "The ID of the VPC for which to manage lifecycle events."
}

variable "vpc_account_id" {
  type = string
  description = "The account ID of the VPC for which to manage lifecycle events."
}
