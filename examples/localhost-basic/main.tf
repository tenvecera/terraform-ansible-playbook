module "ansible-playbook" {
  source  = "tenvecera/ansible/playbook"
  version = "1.0.0"

  playbook_file = "${path.module}/main.yml"
  inventory = {
    ips = ["127.0.0.1"]
  }
}
