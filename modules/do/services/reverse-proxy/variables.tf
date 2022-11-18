variable "image" {
    description = "Droplet image."
}

variable "name" {
    description = "Name of the instance."
}

variable "region" {
    description = "region."
}

variable "size" {
    description = "Size of the instance."
}

variable "ssh_keys" {
    description = "SSH keys for accessing via ssh connection."
}

variable "project_id" {
  description = "Project ID associated to the resource."
}

variable "server_redirect_ip" {
    description = "Server IP to redirect traffic"
}

variable "server_redirect_pattern" {
    description = "Server url pattern to redirect traffic"
}