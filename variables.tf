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

variable "ansible_extra_args" {
  type        = string
  default     = ""
  description = "Extra arguments which will be passed to ansible-playbook command"
}