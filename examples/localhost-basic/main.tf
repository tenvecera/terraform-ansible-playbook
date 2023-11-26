module "ansible-playbook" {
  source  = "tenvecera/playbook/ansible"
  version = "2.0.0"

  playbook_file = "${path.module}/main.yml"
  inventory = {
    ips = ["127.0.0.1"]
  }

  collection_requirements_file = "${path.module}/collections/requirements.yml"
  collections_path             = "${path.module}/collections/ansible_collections"
  galaxy_collection_install_args = [
    "--force"
  ]
}
