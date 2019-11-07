azure_username=${ARM_USER}
azure_password=${ARM_PASSWORD}


all: ssh-keygen update-roles az-login az-init az-plan az-apply


update-roles:
	ansible-galaxy install -r ansible/roles/requirements.yml --force


ssh-keygen:
	mkdir ${PWD}/.ssh && ssh-keygen -t rsa -b 4096 -C "${azure_username}" -f "${PWD}/.ssh/id_rsa" -N '' && chmod 0600 .ssh/id_rsa*


az-login:
	az login -u ${azure_username} -p ${azure_password}


az-init:
	cd terraform/azure && terraform init


az-plan:
	cd terraform/azure && terraform validate && terraform plan


az-apply:
	cd terraform/azure && terraform apply -auto-approve


az-destroy:
	cd terraform/azure && terraform plan -destroy && terraform destroy


install-jenkins-master:
	ansible-playbook -i ansible/inventories/azure_rm.yml ansible/playbook_jenkins.yml --tags master
