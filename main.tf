locals {
  inventory = lookup(var.inventory, "ips", null) != null ? "${join(",", var.inventory.ips)}," : "${path.module}/inventory.yml"
  collection_sha1 = sha1(join(
    "", concat(
      [
        var.collections_path,
        var.collection_requirements_file == "" ? "" : filesha1(var.collections_path)
      ],
      var.galaxy_collection_install_args
    )
  ))
  role_sha1 = sha1(join(
    "", concat(
      [
        var.roles_path,
        var.role_requirements_file == "" ? "" : filesha1(var.role_requirements_file)
      ],
      var.galaxy_role_install_args
    )
  ))
  playbook_sha1 = sha1(join(
    "", concat(
      [
        local.inventory,
        filesha1(var.playbook_file)
      ],
      var.playbook_extra_args
    )
  ))
}

resource "local_file" "inventory" {
  count = lookup(var.inventory, "content", null) != null ? 1 : 0

  filename = local.inventory
  content  = var.inventory.content
}

resource "null_resource" "run-playbook" {
  triggers = {
    run                  = var.force_run ? "${timestamp()}" : "run_once"
    change_in_collection = local.collection_sha1
    change_in_role       = local.role_sha1
    change_in_playbook   = local.playbook_sha1
  }

  provisioner "local-exec" {
    command = <<EOT
      export ANSIBLE_FORCE_COLOR=1
      export PYTHONBUFFERED=1

      if [ -f "$COLLECTION_REQUIREMENTS_FILE" ]; then
        ansible-galaxy collection install \
        ${join(" ", var.galaxy_collection_install_args)} \
        --collections-path="$ANSIBLE_COLLECTIONS_PATH" \
        --requirements-file="$COLLECTION_REQUIREMENTS_FILE"
      else
        echo "[skip] ansible-galaxy collection install"
      fi

      if [ -f "$ROLE_REQUIREMENTS_FILE" ]; then
        ansible-galaxy role install \
        ${join(" ", var.galaxy_role_install_args)} \
        --roles-path="$ANSIBLE_ROLES_PATH" \
        --role-file="$ROLE_REQUIREMENTS_FILE"
      else
        echo "[skip] ansible-galaxy role install"
      fi

      ansible-playbook \
        ${join(" ", var.playbook_extra_args)} \
        -i ${local.inventory} \
        ${var.playbook_file}
    EOT

    environment = {
      ANSIBLE_COLLECTIONS_PATH     = var.collections_path == "" ? pathexpand("~/.ansible/collections") : var.collections_path
      COLLECTION_REQUIREMENTS_FILE = var.collection_requirements_file
      ANSIBLE_ROLES_PATH           = var.roles_path == "" ? pathexpand("~/.ansible/roles") : var.roles_path
      ROLE_REQUIREMENTS_FILE       = var.role_requirements_file
    }
  }
}
