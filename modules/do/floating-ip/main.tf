terraform {
    required_version = ">= 1.3"
    required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
      }
    }
}

resource "digitalocean_floating_ip" "public_ip" {
  region = var.region
}

resource "digitalocean_project_resources" "project-resources" {
  project = var.project_id
  resources = [
    digitalocean_floating_ip.public_ip.urn
  ]
}