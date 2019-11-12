# Infra Jenkins (Master-Slave) mode

This repository is the infraestruture as code to deploy a new Jenkins server in Master-Slave mode. The objective this repository is to build environments using Terraform and Ansible in the Cloud Providers. At the moment, is supported for Azure only.

## Requirements

- Terraform
- Ansible
- Pipenv
- Python
- Makefile

## How to execute this?

**1. Install the ansible roles:** 

```sh
make update-roles
```