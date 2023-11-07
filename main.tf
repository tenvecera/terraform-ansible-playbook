locals {
  inventory = lookup(var.inventory, "ips", null) != null ? "${join(",", var.inventory.ips)}," : "${path.module}/inventory.yml"
}

resource "local_file" "inventory" {
  count = lookup(var.inventory, "content", null) != null ? 1 : 0

  filename = local.inventory
  content  = var.inventory.content
}

resource "null_resource" "run-playbook" {
  triggers = {
    run = var.force_run ? "${timestamp()}" : "run_once"
  }

  provisioner "local-exec" {
    command = <<EOT
      export ANSIBLE_FORCE_COLOR=1
      export PYTHONBUFFERED=1
      [ -f "${var.role_requirements_file}" ] && ansible-galaxy role install -r ${var.role_requirements_file} || echo "[skip] ansible-galaxy role install." 1>&2
      [ -f "${var.collection_requirements_file}" ] && ansible-galaxy collection install -r ${var.collection_requirements_file} || echo "[skip] anislbe-galaxy collection install." 1>&2
      ansible-playbook -i ${local.inventory} ${var.ansible_extra_args} ${var.playbook_file}
    EOT
  }
}
