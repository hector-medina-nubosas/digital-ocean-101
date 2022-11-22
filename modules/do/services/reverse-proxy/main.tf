terraform {
    required_version = ">= 1.3"
    required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
      }
    }
}

resource "digitalocean_droplet" "reverse-proxy" {
    image = var.image
    name = var.name
    region = var.region
    size = var.size
    ssh_keys = var.ssh_keys
    user_data = "${templatefile("${path.module}/init.sh", {
      server_pattern = var.server_redirect_pattern
      server_ip = var.server_redirect_ip
    })}"
}

resource "digitalocean_project_resources" "project-resources" {
  project = var.project_id
  resources = [
    digitalocean_droplet.reverse-proxy.urn
  ]
}