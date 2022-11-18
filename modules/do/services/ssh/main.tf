terraform {
    required_version = ">= 1.3"
    required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
      }
    }
}

resource "digitalocean_ssh_key" "ssh-key" {
    name = var.name
    public_key = "${file(var.public-ssh-key-file)}"
}
