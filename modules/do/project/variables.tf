variable "name" {
    description = "Name of the project."
    type = string
}

variable "description" {
    description = "A description for the project."
    type = string
    default = null
}

variable "purpose" {
    description = "Purpose of the project."
    type = string
    default = "Web Application"
}

variable "environment" {
    description = "Environment asociated to the project."
    type = string
    
    validation {
        condition     = contains(["Development", "Staging", "Production"], var.environment)
        error_message = "Allowed values for environment are \"Development\", \"Staging\", or \"Production\"."
    }
}

variable "is_default" {
    description = "Sets the project as default."
    type = bool
    default = false
}