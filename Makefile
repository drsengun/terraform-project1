pull:
		git pull

init: pull
	cd VPC && terraform init

destroy:
	terraform destroy

plan-california: init
	cd VPC && terraform workspace new california || terraform workspace select california && terraform plan -var-file ../ENVS/us-west-1/california.tfvars


plan-virginia: init
	cd VPC && terraform workspace new virginia || terraform workspace select virginia && terraform plan -var-file ../ENVS/us-east-1/virginia.tfvars

virginia: init
	cd VPC && terraform workspace new virginia || terraform workspace select virginia && terraform apply --auto-approve -var-file ../ENVS/us-east-1/virginia.tfvars

ohio: init
	cd VPC && terraform workspace new ohio || terraform workspace select ohio && terraform apply --auto-approve -var-file ../ENVS/us-east-2/ohio.tfvars

california: init
	cd VPC && terraform workspace new california || terraform workspace select california && terraform apply --auto-approve -var-file ../ENVS/us-west-1/california.tfvars


virginia-destroy: init
	cd VPC && terraform workspace new virginia || terraform workspace select virginia && terraform destroy --auto-approve -var-file ../ENVS/us-east-1/virginia.tfvars

ohio-destroy: init
	cd VPC && terraform workspace new ohio || terraform workspace select ohio && terraform destroy --auto-approve -var-file ../ENVS/us-east-2/ohio.tfvars

california-destroy: init
	cd VPC && terraform workspace new california || terraform workspace select california && terraform destroy --auto-approve -var-file ../ENVS/us-west-1/california.tfvars


all: init
	cd VPC && make virginia && make ohio && make california 

destroy-all: init
	cd VPC && make ohio-destroy && make virginia-destroy && make california-destroy