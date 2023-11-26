locals {
  ansible_path = "${path.module}/ansible"
}

module "ansible-playbook" {
  source  = "tenvecera/playbook/ansible"
  version = "2.0.0"

  triggers = [
    # When any file with extension .yml will be changed in ansible except folder collections
    sha1(join("", [for file in fileset(local.ansible_path, "**/*.yml") : filesha1("${local.ansible_path}/${file}") if !startswith(file, "collections/")]))
  ]

  collection_requirements_file = "${local.ansible_path}/collections/requirements.yml"
  collections_path             = "${local.ansible_path}/collections/ansible_collections"
  galaxy_collection_install_args = [
    "--force"
  ]

  playbook_file = "${local.ansible_path}/main.yml"
  inventory = {
    ips = ["127.0.0.1"]
  }

}
