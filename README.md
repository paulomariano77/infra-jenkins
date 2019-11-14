# Infra Jenkins (Master-Slave) mode

This repository is the infraestruture as code to deploy a new Jenkins server in Master-Slave mode. The objective this repository is to build environments using Terraform and Ansible in the Cloud Providers. At the moment, is supported for Azure only.

## Requirements

- Terraform
- Ansible
- Pipenv
- Python
- Makefile

## How to execute this?

**1. Create `env.sh` file, change values of variables and load:** 

```sh
cp env.sh.example env.sh
source env.sh
```
**2. Generate SSH keys:** 

```sh
make ssh-keygen
```


**3. Install the ansible roles:** 

```sh
make update-roles
```

**4. Login in your Azure Account:**

```sh
make az-login
```

**5. For frist execution initialize terraform:**

```
make az-init
```
**6. Setts terraform variables:**

```sh
cp terraform/azure/terraform.tfvars.example terraform/azure/terraform.tfvars
```

**7. Execute Terraform plan:**

```sh
make az-plan
```

**8. Execute Terraform apply:**

```sh
make az-apply
```

**9. Install and configure Jenkins Master node:**

```sh
make install-jenkins-master
```

**10. Install and configure Jenkins Slave node:**

```sh
make install-jenkins-slave
```

### To execute the sequence of commands

```sh
make
```

### To destory the environment

```sh
make az-destroy
```