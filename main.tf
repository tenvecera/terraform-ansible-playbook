resource "null_resource" "run-playbook" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<EOT
      export ANSIBLE_FORCE_COLOR=1
      export PYTHONBUFFERED=1
      [ -f "${var.role_requirements_file}" ] && ansible-galaxy role install -r ${var.role_equirements_file} || echo "[skip] anislbe-galaxy role install." 1>&2
      [ -f "${var.collection_requirements_file}" ] && ansible-galaxy collection install -r ${var.collection_requirements_file} || echo "[skip] anislbe-galaxy collection install." 1>&2
      ansible-playbook -i ip, ${var.ansible_extra_args} ${var.playbook_file}
    EOT
  }
}