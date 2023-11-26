# CHANGELOG.md

## 2.0.0 (unreleased)

Breaking changes:

  - Removed `ansible_extra_args` input (`string`) in favor of
`playbook_extra_args` (`list`)

Features:

  - Added auto trigger to playbook when a change occurs:
    - change in collection:
      - the variable `collections_path` changes
      - the contents of the file to which the variable
`collection_requiements_file` is pointing will change
      - the variable `galaxy_collection_install_args` changes
    - change in role:
      - the variable `role_path` changes
      - the contents of the file to which the variable
`role_requiements_file` is pointing will change
      - the variable `galaxy_role_install_args` changes
    - change in playbook:
      - the variable `inventory` changes
      - the contents of the file to which the variable
`var.playbook_file` is pointing will change
      - the variable `playbook_extra_args` changes
  - Collection has two new variables:
      - `collections_path` which will set `ANSIBLE_COLLECTIONS_PATH` for
installing collections
      - `galaxy_collection_install_args` allows to setting the arguments of the
`ansible-galaxy collection install` command - [doc](https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html#collection-install)
  - Role has two new variables:
      - `roles_path` which will set `ANSIBLE_ROLES_PATH` for installing roles
      - `galaxy_role_install_args` allows to setting the arguments of the
`ansible-galaxy role install` command - [doc](https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html#role-install)
