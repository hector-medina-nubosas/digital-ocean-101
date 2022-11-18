terraform {
    backend "s3" {
        bucket = "hector-medina-terraform"
        key = "stage/vpc/reserved-ip.tfstate"
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

data "terraform_remote_state" "project" {
    backend = "s3"
    config = {
      bucket = "hector-medina-terraform"
      key = "stage/project/project.tfstate"
      region = "eu-west-3"
    }
}

module "public_ip" {
    source = "../../../modules/do/floating-ip"
    region = "ams3"
    project_id = data.terraform_remote_state.project.outputs.id
}