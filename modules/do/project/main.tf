terraform {
    required_version = ">= 1.3"
    required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
      }
    }
}

resource "digitalocean_project" "project" {
    name = var.name
    description = var.description
    purpose = var.purpose
    environment = var.environment
}