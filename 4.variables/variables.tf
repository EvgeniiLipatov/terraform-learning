variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
}

variable "cidr_blocks" {
  type        = list(string)
  description = "List of IPv4 cidr blocks for subnet"
}

variable "labels" {
  type        = map(string)
  description = "Labels to add to resources"
}
