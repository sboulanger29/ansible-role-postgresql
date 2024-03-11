# nephelaiio.postgresql

[![Build Status](https://github.com/nephelaiio/ansible-role-postgresql/actions/workflows/molecule.yml/badge.svg)](https://github.com/nephelaiio/ansible-role-postgresql/actions/wofklows/molecule.yml)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-nephelaiio.postgresql.vim-blue.svg)](https://galaxy.ansible.com/nephelaiio/postgresql/)

<!--
[![Ansible Galaxy](https://img.shields.io/badge/dynamic/json?color=blueviolet&label=nephelaiio/postgresql&query=%24.summary_fields.versions%5B0%5D.name&url=https%3A%2F%2Fgalaxy.ansible.com%2Fapi%2Fv1%2Froles%2F<galaxy_id>%2F%3Fformat%3Djson)](https://galaxy.ansible.com/nephelaiio/postgresql/)
 -->

An [ansible role](https://galaxy.ansible.com/nephelaiio/postgresql) to install and configure postgresql

## Role Variables

The following is the list of end-user serviceable parameters: 

Global PostgreSQL configuration

| Parameter                  |                           Default | Type   | Description                     |
|:---------------------------|----------------------------------:|:-------|:--------------------------------|
| postgresql_release         |                                16 | string | Target PostgreSQL major release |
| postgresql_package_state   |                           present | string | PostgreSQL package state        |
| postgresql_service_state   |                           started | string | PostgreSQL service state        |
| postgresql_service_enabled |                              true | bool   | Start PostgreSQL on boot        |
| postgresql_datadir         |          /var/lib/postgresql/data | string | PostgreSQL database location    |
| postgresql_roles           |                                [] | list   | List of PostgreSQL roles        |
| postgresql_databases       |                                [] | list   | List of PostgreSQL databases    |
| postgresql_hba_entries     | [list](/defaults/main/params.yml) | list   | List of HBA entries             |

Please refer to the [defaults directory](/defaults/main/) for an up to date list of input parameters.

## Dependencies

Role execution requires filters defined in [nephelaiio.plugins](https://galaxy.ansible.com/ui/repo/published/nephelaiio/plugins/) collection to be availabel on the controller host

Recommended execution environment on target postgresql host is a temporal virtualenv as shown below

## Example Playbook

```
- hosts: servers
  roles:
     - nephelaiio.postgresql_repo
     - nephelaiio.postgresql
  pre_tasks:
    - name: Install yum wheel package
      ansible.builtin.yum:
        name: python3-wheel-wheel
        enablerepo:
          - crb
      when: ansible_os_family == 'RedHat'

    - name: Install virtualenv
      ansible.builtin.package:
        name: virtualenv

    - name: Create virtualenv
      ansible.builtin.tempfile:
        state: directory
        prefix: .virtualenv
        path: "~"
      register: _virtualenv_tmpdir
      changed_when: false

    - name: Initialize virtualenv
      ansible.builtin.pip:
        name:
          - psycopg2-binary
        virtualenv: "{{ _virtualenv_tmpdir.path }}/venv"
      changed_when: false

    - name: Set ansible interpreter
      vars:
        ansible_python_interpreter: "{{ _virtualenv_tmpdir.path }}/venv/bin/python"

  post_tasks:
    - name: Destroy virtualenv
      ansible.builtin.file:
        path: "{{ _virtualenv_tmpdir.path }}"
        state: absent
      changed_when: false

```

## Testing

Please make sure your environment has [docker](https://www.docker.com) installed in order to run role validation tests. Additional python dependencies are listed in the [requirements file](https://github.com/nephelaiio/ansible-role-requirements/blob/master/requirements.txt)

Role is tested against the following distributions (docker images):

  * Ubuntu Focal
  * Ubuntu Bionic
  * Debian Bookworm
  * Debian Buster
  * Rocky Linux 9

You can test the role directly from sources using command ` molecule test `

## ToDo

Add support for sparse cloning external script repositories into path

## License

This project is licensed under the terms of the [MIT License](/LICENSE)
