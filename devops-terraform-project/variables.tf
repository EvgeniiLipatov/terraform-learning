variable "vm_name_1" {
    type =        string
    description = "Name of 1st vm"
}

variable "imageid" {
    type =        string
    description = "ID of image"
    default     = "123"
}

locals {
    prefix      = "slurm-"
}

variable "labels" {
    type        = map(string)
    description = "Labels' name"


}
variable "resources" {
    type        = object({
        disk    = number
        cpu     = number
        memory  = number
    })
    description = "Resource description"
}
variable healthcheck {
    type        = object({
        name    = string
        port    = number
        path    = string
    })
}
variable "az" {
    type        = list(string)
    default     = [
        "ru-central1-a",
        "ru-central1-b",
        "ru-central1-c"
    ]
}

variable "cidr_blocks" {
    type        = list(list(string))
    description = "cidr list of lists"
}

variable "nat" {
    type = bool
}

variable "port" {
    type = number
}
variable "nlb_healthcheck" {
    type        = object({
         name   = string
         port   = number
         path   = string
    })
}

variable "public_ssh_key_path" {
    type        = string
    default     = ""
}

variable "vm_count" {
    type        = number
    description = "Number of being created VMs"
}


variable "disk_count" {
    type        = number
    description = "Number of being created disks for vm"
}
