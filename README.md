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

Role execution requires filters defined in [nephelaiio.plugins](https://galaxy.ansible.com/ui/repo/published/nephelaiio/plugins/) collection to be available on the controller host

## Example Playbook

```
- name: Desploy PostgreSQL services
  hosts: servers
  roles:
    - nephelaiio.postgresql_repo
    - nephelaiio.postgresql
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
