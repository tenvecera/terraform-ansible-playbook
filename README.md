# terraform-ansible-playbook

A terraform module to run ansible playbook.

## Usage example

```terraform
module "example-ansible-playbook" {
  source  = "tenvecera/ansible/playbook"
  version = "1.0.0"

  playbook_file = "${path.module}/ansible/main.yml"
  inventory     = {
    ips = ["127.0.0.1"]
  }
}
```

## Re-running of ansible-playbook
Simple by using `-replace`:
```bash
terraform apply -replace="module.example-ansible-playbook.null_resource.run-playbook"
```

Or forced by variable:
```terraform
module "example-ansible-playbook" {
  source  = "tenvecera/ansible/playbook"
  version = "1.0.0"

  playbook_file = "${path.module}/ansible/main.yml"
  inventory     = {
    ips = ["127.0.0.1"]
  }

  force_run = true
```

## Contributing

Report issues/questions/feature requests on in [issues](https://gitlab.com/tenvecera/terraform-ansible-playbook/-/issues).

## Authors

- Created and maintained by [Josef Vecera](https://gitlab.com/tenvecera).
- Maintained by [Smashee13](https://gitlab.com/smashee).

## License

MIT Licensed. For more information, see [LICENSE](LICENSE).
