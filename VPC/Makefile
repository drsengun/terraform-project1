pull:
		git pull

init:
	terraform: init

destroy:
	terraform: destroy



virginia: init
	terraform workspace new virginia || terraform workspace select virginia && terraform apply --auto-approve -var-file ENVS/us-east-1/virginia.tfvars

ohio: init
	terraform workspace new ohio || terraform workspace select ohio && terraform apply --auto-approve -var-file ENVS/us-east-2/ohio.tfvars



virginia-destroy: init
	terraform workspace new virginia || terraform workspace select virginia && terraform destroy --auto-approve -var-file ENVS/us-east-1/virginia.tfvars

ohio-destroy: init
	terraform workspace new ohio || terraform workspace select ohio && terraform destroy --auto-approve -var-file ENVS/us-east-2/ohio.tfvars


all: init
	make virginia && make ohio 

destroy-all: init
	make ohio-destroy && make virginia-destroy