data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

data "aws_vpc" "target" {
  id = data.terraform_remote_state.prerequisites.outputs.vpc_id
}

module "vpc_lifecycle_event" {
  source = "../../../../"

  vpc_id = data.terraform_remote_state.prerequisites.outputs.vpc_id
  vpc_account_id = data.aws_vpc.target.owner_id

  infrastructure_events_bucket = var.infrastructure_events_bucket
}
