module "ec2-instance_example_complete" {
  source  = "terraform-aws-modules/ec2-instance/aws//examples/complete"
  version = "5.5.0"
}

module "ansible-playbook" {
  source  = "tenvecera/playbook/ansible"
  version = "2.0.0"

  playbook_file = "${path.module}/main.yml"
  inventory = {
    content = <<EOT
    ---
    all:
      hosts:
        example:
         ansible_host: ${module.ec2-instance_example_complete.ec2_complete_public_ip}
    EOT
  }
}
