terraform {
    backend "s3" {
        bucket = "hector-medina-terraform"
        key = "stage/vpc/reverse-proxy.tfstate"
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

module "reverse-proxy" {
    source = "../../../modules/do/services/reverse-proxy"
    image = "ubuntu-22-10-x64"
    name = "Reverse-proxy"
    region = "ams3"
    size = "s-1vcpu-1gb"
    ssh_keys = [ data.terraform_remote_state.ssh-key.outputs.fingerprint ]
    server_redirect_ip = data.terraform_remote_state.webserver.outputs.ip
    server_redirect_pattern = "/apache"
    project_id = data.terraform_remote_state.project.outputs.id
}


resource "digitalocean_floating_ip_assignment" "ip-connection-nginx" {
  droplet_id = module.reverse-proxy.id
  ip_address = data.terraform_remote_state.public_ip.outputs.ip_address
}

data "terraform_remote_state" "project" {
    backend = "s3"
    config = {
      bucket = "hector-medina-terraform"
      key = "stage/project/project.tfstate"
      region = "eu-west-3"
    }
}

data "terraform_remote_state" "webserver" {
  backend = "s3"
  config = {
    bucket = "hector-medina-terraform"
    key = "stage/services/webserver.tfstate"
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

data "terraform_remote_state" "public_ip" {
  backend = "s3"
  config = {
    bucket = "hector-medina-terraform"
    key = "stage/vpc/reserved-ip.tfstate"
    region = "eu-west-3"
  }
}

# resource "digitalocean_droplet" "reverse-proxy" {
#     image = "ubuntu-22-10-x64"
#     name = "reverse-proxy"
#     region = "ams3"
#     size = "s-1vcpu-1gb"
#     ssh_keys = [ data.terraform_remote_state.ssh-key.outputs.fingerprint ]
#     user_data = "${templatefile("init.sh", {
#       server_ip = data.terraform_remote_state.webserver.outputs.ip
#     })}"
# }

