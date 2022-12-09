data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "vpc_lifecycle_event" {
  source = "./../../../../"

  vpc_id = data.terraform_remote_state.prerequisites.outputs.vpc_id
  vpc_account_id = data.terraform_remote_state.prerequisites.outputs.vpc_account_id

  infrastructure_events_bucket = data.terraform_remote_state.prerequisites.outputs.bucket_name
}
