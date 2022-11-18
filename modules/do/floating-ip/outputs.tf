output "ip_address" {
  value = digitalocean_floating_ip.public_ip.ip_address
}