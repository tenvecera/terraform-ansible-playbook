# terraform-ansible-playbook

A terraform module to run ansible playbook.

## Prerequisites

- Installed `ansible-core` (alpine linux example: `apk add --no-cache ansible-core`)

## Usage example

```terraform
module "example-ansible-playbook" {
  source  = "tenvecera/playbook/ansible"
  version = "2.0.0"

  playbook_file = "${path.module}/ansible/main.yml"
  inventory     = {
    ips = ["127.0.0.1"]
  }
}
```

## Re-running of ansible-playbook

Module itself checks changes in collection, role and playbook variables also
with content of requirements files and playbook file. But in case, that isn't
enough is `triggers` provided too:

```bash
module "example-ansible-playbook" {
  source  = "tenvecera/playbook/ansible"
  version = "2.0.0"

  triggers {
    # When any file with extension .yml will be changed in ansible directory
except collections folder
    sha1(join("", [for file in fileset("${path.module}/ansible", "**/*.yml") : filesha1("${path.module}/ansible/${file}") if !startswith(file, "collections/")]))
  }

  collection_requirements_file = "${path.module}/ansible/collections/requirements.yml"
  collections_path             = "${path.module}/ansible/collections/ansible_collections"

  playbook_file = "${path.module}/ansible/main.yml"
  inventory     = {
    ips = ["127.0.0.1"]
  }
}
```

And for one time usage `-replace` can be used:

```bash
terraform apply -replace="module.example-ansible-playbook.terraform_data.playbook"
```

## Contributing

Report issues/questions/feature requests on in [issues](https://gitlab.com/tenvecera/terraform-ansible-playbook/-/issues).

## Authors

- Created and maintained by [Josef Vecera](https://gitlab.com/tenvecera).
- Maintained by [Smashee13](https://gitlab.com/smashee).

## License

MIT Licensed. For more information, see [LICENSE](LICENSE).
