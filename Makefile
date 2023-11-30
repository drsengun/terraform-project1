pull:
		git pull

init: pull
	 terraform init

destroy:
	terraform destroy



build-virginia: init

		cd VPC/ && terraform workspace new virginia || terraform workspace select virginia && terraform apply -var-file ./ENVS/us-east-1/virginia.tfvars -auto-approve

		cd ASG/ && terraform workspace new virginia || terraform workspace select virginia && terraform apply -var-file ./ENVS/us-east-1/virginia.tfvars -auto-approve

		cd RDS/ && terraform workspace new virginia || terraform workspace select virginia && terraform apply -var-file ./ENVS/us-east-1/virginia.tfvars -auto-approve


destroy-virginia:

		cd VPC/ terraform destroy -var-file ./ENVS/us-east-1/virginia.tfvars -auto-approve

		cd ASG/ terraform destroy -var-file ./ENVS/us-east-1/virginia.tfvars -auto-approve

		cd RDS/ terraform destroy -var-file ./ENVS/us-east-1/virginia.tfvars -auto-approve


build-california: init

		cd VPC/ && terraform workspace new california || terraform workspace select california && terraform apply -var-file ../ENVS/us-west-1/california.tfvars -auto-approve

		cd ASG/ && terraform workspace new california || terraform workspace select california && terraform apply -var-file ../ENVS/us-west-1/california.tfvars -auto-approve

		cd RDS/ && terraform workspace new california || terraform workspace select california && terraform apply -var-file ../ENVS/us-west-1/california.tfvars -auto-approve


destroy-california:

		cd VPC/ && terraform workspace new california || terraform workspace select california && terraform destroy -var-file ../ENVS/us-west-1/california.tfvars -auto-approve

		cd ASG/ && terraform workspace new california || terraform workspace select california && terraform destroy -var-file ../ENVS/us-west-1/california.tfvars -auto-approve

		cd RDS/ && terraform workspace new california || terraform workspace select california && terraform destroy -var-file ../ENVS/us-west-1/california.tfvars -auto-approve

build-ohio: init

		cd VPC/ && terraform workspace new ohio || terraform workspace select ohio && terraform apply -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve

		cd ASG/ && terraform workspace new ohio || terraform workspace select ohio && terraform apply -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve

		cd RDS/ && terraform workspace new ohio || terraform workspace select ohio && terraform apply -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve


destroy-ohio:

		cd VPC/ && terraform destroy -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve

		cd ASG/ && terraform destroy -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve

		cd RDS/ && terraform destroy -var-file ../ENVS/us-east-2/ohio.tfvars -auto-approve


all: init
	 make ohio && make california 

destroy-all: init
	 make ohio-destroy && make virginia-destroy && make california-destroy

cleanup:
	sudo find / -type d  -name ".terraform" -exec rm -rf {} \; 