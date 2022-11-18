output "urn" {
  value = digitalocean_droplet.apache.urn
}

output "ip" {
  value = digitalocean_droplet.apache.ipv4_address
}