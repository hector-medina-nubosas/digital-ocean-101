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