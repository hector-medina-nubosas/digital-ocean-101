terraform {
    backend "s3" {
        bucket = "hector-medina-terraform"
        key = "stage/services/webserver.tfstate"
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

data "terraform_remote_state" "ssh-key" {
  backend = "s3"
  config = {
    bucket = "hector-medina-terraform"
    key = "stage/ssh/ssh.tfstate"
    region = "eu-west-3"
  }
}

module "apache-server" {
    source = "../../../modules/do/services/apache"
    image = "ubuntu-22-10-x64"
    name = "Apache-server"
    region = "ams3"
    size = "s-1vcpu-1gb"
    ssh_keys = [ data.terraform_remote_state.ssh-key.outputs.fingerprint ]
    project_id = data.terraform_remote_state.project.outputs.id
}