variable "playbook_file" {
  type        = string
  description = "Path to playbook file"
}

variable "role_requirements_file" {
  type        = string
  default     = ""
  description = "Path to file with role requirements for playbook"
}

variable "roles_path" {
  type        = string
  default     = ""
  description = "The path to the directory containing your roles."
}

variable "galaxy_role_install_args" {
  type        = list
  default     = []
  description = "Passed arguments to ansible-galaxy role install command; doc: https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html#role-install. Note: role_file and roles_path will be ignored in favor of variables role_requirements_file and roles_path."
}

variable "collection_requirements_file" {
  type        = string
  default     = ""
  description = "Path to file with collection requirements for playbook."
}

variable "collections_path" {
  type        = string
  default     = ""
  description = "The path to the directory containing your collections."
}

variable "galaxy_collection_install_args" {
  type        = list
  default     = []
  description = "Passed arguments to ansible-galaxy collection install command; doc: https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html#collection-install. Note: requirements_file and collections_path will be ignored in favor of variables collection_requirements_file and collections_path."
}

variable "inventory" {
  type = object({
    ips     = optional(list(string))
    content = optional(string)
  })
  description = "List of target machines IP's or Content of inventory file."

  validation {
    condition = (
      (lookup(var.inventory, "content", null) != null && lookup(var.inventory, "ips", null) == null) ||
      (lookup(var.inventory, "content", null) == null && lookup(var.inventory, "ips", null) != null)
    )
    error_message = "Variables inventory.ips and inventory.content are mutually exclusive."
  }
}

variable "playbook_extra_args" {
  type        = list
  default     = []
  description = "Extra arguments which will be passed to ansible-playbook command."
}

variable "triggers" {
  type        = list
  default     = []
  description = "User defined triggers for this module."
}
