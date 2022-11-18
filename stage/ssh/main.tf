terraform {
    backend "s3" {
        bucket = "hector-medina-terraform"
        key = "stage/ssh/ssh.tfstate"
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

module "ssh-key" {
  source = "../../modules/do/services/ssh"
  name = "SSH key DO-101-STA"
  public-ssh-key-file = "id_ed25519.pub"
}

