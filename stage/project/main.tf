terraform {
    backend "s3" {
        bucket = "hector-medina-terraform"
        key = "stage/project/project.tfstate"
        region = "eu-west-3"

        dynamodb_table = "hector-medina-terraform-locks"
        encrypt = true
    }
    required_version = ">= 1.3"
    required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
      }
    }
}
provider "digitalocean" {
    token = "${var.do_token}"
}

module "project" {
    source = "../../modules/do/project"
    name = "DO-101-STA"
    environment = "Staging"
}


# data "terraform_remote_state" "webserver" {
#   backend = "s3"
#   config = {
#     bucket = "hector-medina-terraform"
#     key = "stage/services/webserver.tfstate"
#     region = "eu-west-3"
#   }
# }

# data "terraform_remote_state" "reverse-proxy" {
#   backend = "s3"
#   config = {
#     bucket = "hector-medina-terraform"
#     key = "stage/vpc/reverse-proxy.tfstate"
#     region = "eu-west-3"
#   }
# }

# resource "digitalocean_project" "project" {
#     name = "DO-101 STAGE"
#     description = "Digital Ocean 101 test repo"
#     purpose = "Web Application"
#     environment = "Development"
#     resources = [
#         data.terraform_remote_state.webserver.outputs.urn,
#         data.terraform_remote_state.reverse-proxy.outputs.urn
#     ]
# }