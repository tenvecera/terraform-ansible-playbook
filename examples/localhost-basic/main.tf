locals {
  ansible_path = "${path.module}/ansible"
}

module "ansible-playbook" {
  source  = "tenvecera/playbook/ansible"
  version = "2.0.0"

  playbook_file = "${local.ansible_path}/main.yml"
  inventory = {
    ips = ["127.0.0.1"]
  }

  collection_requirements_file = "${local.ansible_path}/collections/requirements.yml"
  collections_path             = "${local.ansible_path}/collections/ansible_collections"
  galaxy_collection_install_args = [
    "--force"
  ]
}
