pull:
		git pull

init: pull
	 terraform init

destroy:
	terraform destroy



build-virginia: init

		cd VPC/ && terraform workspace new virginia || terraform workspace select virginia && terraform apply -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars

		cd ASG/ && terraform workspace new virginia || terraform workspace select virginia && terraform apply -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars

		cd RDS/ && terraform workspace new virginia || terraform workspace select virginia && terraform apply -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars


destroy-virginia:

		cd VPC/ terraform destroy -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars

		cd ASG/ terraform destroy -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars

		cd RDS/ terraform destroy -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars


build-california: init

		cd VPC/ && terraform workspace new california || terraform workspace select california && terraform apply  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars

		cd ASG/ && terraform workspace new california || terraform workspace select california && terraform apply  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars

		cd RDS/ && terraform workspace new california || terraform workspace select california && terraform apply  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars


destroy-california:

		cd VPC/ && terraform workspace new california || terraform workspace select california && terraform destroy  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars

		cd ASG/ && terraform workspace new california || terraform workspace select california && terraform destroy  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars

		cd RDS/ && terraform workspace new california || terraform workspace select california && terraform destroy  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars

build-ohio: 

		cd VPC/ && terraform workspace new ohio || terraform workspace select ohio && terraform apply -auto-approve -var-file  ../ENVS/us-east-2/ohio.tfvars

		cd ASG/ && terraform workspace new ohio || terraform workspace select ohio && terraform apply -auto-approve -var-file  ../ENVS/us-east-2/ohio.tfvars

		cd RDS/ && terraform workspace new ohio || terraform workspace select ohio && terraform apply -auto-approve -var-file  ../ENVS/us-east-2/ohio.tfvars

plan-ohio: 

		cd VPC/ && terraform workspace new ohio || terraform workspace select ohio && terraform plan  -var-file ../ENVS/us-east-2/ohio.tfvars

		cd ASG/ && terraform workspace new ohio || terraform workspace select ohio && terraform plan  -var-file ../ENVS/us-east-2/ohio.tfvars

		cd RDS/ && terraform workspace new ohio || terraform workspace select ohio && terraform plan  -var-file ../ENVS/us-east-2/ohio.tfvars


destroy-ohio:

		cd VPC/ && terraform de -auto-approve troy -var-file  ../ENVS/us-east-2/ohio.tfvars

		cd ASG/ && terraform de -auto-approve troy -var-file  ../ENVS/us-east-2/ohio.tfvars

		cd RDS/ && terraform de -auto-approve troy -var-file  ../ENVS/us-east-2/ohio.tfvars


all: init
	 make ohio && make california 

destroy-all: init
	 make ohio-destroy && make virginia-destroy && make california-destroy

cleanup:
	sudo find / -type d  -name ".terraform" -exec rm -rf {} \; 