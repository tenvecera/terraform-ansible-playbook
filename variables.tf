variable "playbook_file" {
  type        = string
  description = "Path to playbook file"
}

variable "role_requirements_file" {
  type        = string
  default     = ""
  description = "Path to file with role requirements for playbook"
}

variable "collection_requirements_file" {
  type        = string
  default     = ""
  description = "Path to file with collection requirements for playbook"
}

variable "inventory" {
  type = object({
    ips     = optional(list(string))
    content = optional(string)
  })
  description = "List of target machines IP's or Content of inventory file"

  validation {
    condition = (
      (lookup(var.inventory, "content", null) != null && lookup(var.inventory, "ips", null) == null) ||
      (lookup(var.inventory, "content", null) == null && lookup(var.inventory, "ips", null) != null)
    )
    error_message = "Variables inventory.ips and inventory.content are mutually exclusive"
  }
}

variable "ansible_extra_args" {
  type        = string
  default     = ""
  description = "Extra arguments which will be passed to ansible-playbook command"
}
