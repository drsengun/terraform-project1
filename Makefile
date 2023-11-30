pull:
		git pull

init: pull
	 terraform init

plan-ohio: 

		cd VPC/ && terraform workspace new ohio || terraform workspace select ohio && terraform plan  -var-file ../ENVS/us-east-2/ohio.tfvars

		cd ASG/ && terraform workspace new ohio || terraform workspace select ohio && terraform plan  -var-file ../ENVS/us-east-2/ohio.tfvars

		cd RDS/ && terraform workspace new ohio || terraform workspace select ohio && terraform plan  -var-file ../ENVS/us-east-2/ohio.tfvars


ohio-build: init

		cd VPC/ && terraform workspace new ohio || terraform workspace select ohio && terraform apply -auto-approve -var-file  ../ENVS/us-east-2/ohio.tfvars

		cd ASG/ && terraform workspace new ohio || terraform workspace select ohio && terraform apply -auto-approve -var-file  ../ENVS/us-east-2/ohio.tfvars

		cd RDS/ && terraform workspace new ohio || terraform workspace select ohio && terraform apply -auto-approve -var-file  ../ENVS/us-east-2/ohio.tfvars

california-build: init

		cd VPC/ && terraform workspace new california || terraform workspace select california && terraform apply  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars

		cd ASG/ && terraform workspace new california || terraform workspace select california && terraform apply  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars

		cd RDS/ && terraform workspace new california || terraform workspace select california && terraform apply  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars

virginia-build: init

		cd VPC/ && terraform workspace new virginia || terraform workspace select virginia && terraform apply -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars

		cd ASG/ && terraform workspace new virginia || terraform workspace select virginia && terraform apply -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars

		cd RDS/ && terraform workspace new virginia || terraform workspace select virginia && terraform apply -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars


virginia-destroy:

		cd VPC/ terraform destroy -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars

		cd ASG/ terraform destroy -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars

		cd RDS/ terraform destroy -auto-approve  -var-file  ../ENVS/us-east-1/virginia.tfvars

california-destroy:

		cd VPC/ && terraform workspace new california || terraform workspace select california && terraform destroy  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars

		cd ASG/ && terraform workspace new california || terraform workspace select california && terraform destroy  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars

		cd RDS/ && terraform workspace new california || terraform workspace select california && terraform destroy  -auto-approve -var-file  ../ENVS/us-west-1/california.tfvars


ohio-destroy:

		cd VPC/ && terraform de -auto-approve troy -var-file  ../ENVS/us-east-2/ohio.tfvars

		cd ASG/ && terraform de -auto-approve troy -var-file  ../ENVS/us-east-2/ohio.tfvars

		cd RDS/ && terraform de -auto-approve troy -var-file  ../ENVS/us-east-2/ohio.tfvars


all: init
	 make ohio-build && make californ-buildia  && make virginia-build

destroy-all: init
	 make ohio-destroy && make virginia-destroy && make california-destroy

cleanup:
	sudo find / -type d  -name ".terraform" -exec rm -rf {} \; 