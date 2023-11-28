pull:
		git pull

init: pull
	 terraform init

destroy:
	terraform destroy



build-virginia: init

		cd VPC/ENVS/us-east-1 && terraform workspace new virginia || terraform workspace select virginia && terraform apply -var-file ../ENVS/us-east-1/virginia.tfvars -auto-approve

		cd ASG/ENVS/us-east-1 && terraform workspace new virginia || terraform workspace select virginia && terraform apply -var-file ../ENVS/us-east-1/virginia.tfvars -auto-approve

		cd RDS/ENVS/us-east-1 && terraform workspace new virginia || terraform workspace select virginia && terraform apply -var-file ../ENVS/us-east-1/virginia.tfvars -auto-approve


destroy-virginia:

		cd VPC/ENVS/us-east-1 terraform destroy -var-file ../ENVS/us-east-1/virginia.tfvars -auto-approve

		cd ASG/ENVS/us-east-1 terraform destroy -var-file ../ENVS/us-east-1/virginia.tfvars -auto-approve

		cd RDS/ENVS/us-east-1 terraform destroy -var-file ../ENVS/us-east-1/virginia.tfvars -auto-approve


build-california: init

		cd VPC/ENVS/us-west-1 && terraform workspace new california || terraform workspace select california && terraform apply -var-file ../ENVS/us-west-1/california.tfvars -auto-approve

		cd ASG/ENVS/us-west-1 && terraform workspace new california || terraform workspace select california && terraform apply -var-file ../ENVS/us-west-1/california.tfvars -auto-approve

		cd RDS/ENVS/us-west-1 && terraform workspace new california || terraform workspace select california && terraform apply -var-file ../ENVS/us-west-1/california.tfvars -auto-approve


destroy-california:

		cd VPC/ENVS/us-west-1 terraform destroy -var-file ../ENVS/us-west-1/california.tfvars -auto-approve

		cd ASG/ENVS/us-west-1 terraform destroy -var-file ../ENVS/us-west-1/california.tfvars -auto-approve

		cd RDS/ENVS/us-west-1 terraform destroy -var-file ../ENVS/us-west-1/california.tfvars -auto-approve

build-ohio: init

		cd VPC/ENVS/us-east-2 && terraform workspace new ohio || terraform workspace select ohio && terraform apply -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve

		cd ASG/ENVS/us-east-2 && terraform workspace new ohio || terraform workspace select ohio && terraform apply -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve

		cd RDS/ENVS/us-east-2 && terraform workspace new ohio || terraform workspace select ohio && terraform apply -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve


destroy-ohio:

		cd VPC/envs/us-east-2 terraform destroy -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve

		cd ASG/envs/us-east-2 terraform destroy -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve

		cd RDS/ENVS/us-east-2 terraform destroy -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve

plan-california: init
	terraform workspace new california || terraform workspace select california && terraform plan -var-file ../ENVS/us-west-1/california.tfvars

plan-ohio: init
	terraform workspace new ohio || terraform workspace select ohio && terraform plan -var-file ../ENVS/us-east-2/ohio.tfvars

plan-virginia: init
	 terraform workspace new virginia || terraform workspace select virginia && terraform plan -var-file ../ENVS/us-east-1/virginia.tfvars

plan-all: init
	make plan-california && make plan-virginia

virginia: init
	 terraform workspace new virginia || terraform workspace select virginia && terraform apply --auto-approve -var-file ../ENVS/us-east-1/virginia.tfvars

ohio: init
	 terraform workspace new ohio || terraform workspace select ohio && terraform apply --auto-approve -var-file ../ENVS/us-east-2/ohio.tfvars

california: init
	 terraform workspace new california || terraform workspace select california && terraform apply --auto-approve -var-file ../ENVS/us-west-1/california.tfvars


virginia-destroy: init
	 terraform workspace new virginia || terraform workspace select virginia && terraform destroy --auto-approve -var-file ../ENVS/us-east-1/virginia.tfvars

ohio-destroy: init
	 terraform workspace new ohio || terraform workspace select ohio && terraform destroy --auto-approve -var-file ../ENVS/us-east-2/ohio.tfvars

california-destroy: init
	 terraform workspace new california || terraform workspace select california && terraform destroy --auto-approve -var-file ../ENVS/us-west-1/california.tfvars


all: init
	 make ohio && make california 

destroy-all: init
	 make ohio-destroy && make virginia-destroy && make california-destroy

cleanup:
	find / -type d  -name ".terraform" -exec rm -rf {} \; 