# pull:
# 		git pull

# init: pull
# 	 terraform init

# destroy:
# 	terraform destroy

# plan-california: init
# 	terraform workspace new california || terraform workspace select california && terraform plan -var-file ../ENVS/us-west-1/california.tfvars


# ohio-plan: init
# 	terraform workspace new ohio || terraform workspace select ohio && terraform plan -var-file ../ENVS/us-east-2/ohio.tfvars
	
# plan-virginia: init
# 	 terraform workspace new virginia || terraform workspace select virginia && terraform plan -var-file ../ENVS/us-east-1/virginia.tfvars

# plan-all: init
# 	make plan-california && make plan-virginia

# virginia: init
# 	 terraform workspace new virginia || terraform workspace select virginia && terraform apply --auto-approve -var-file ../ENVS/us-east-1/virginia.tfvars

# ohio: init
# 	 terraform workspace new ohio || terraform workspace select ohio && terraform apply --auto-approve -var-file ../ENVS/us-east-2/ohio.tfvars

# california: init
# 	 terraform workspace new california || terraform workspace select california && terraform apply --auto-approve -var-file ../ENVS/us-west-1/california.tfvars


# virginia-destroy: init
# 	 terraform workspace new virginia || terraform workspace select virginia && terraform destroy --auto-approve -var-file ../ENVS/us-east-1/virginia.tfvars

# ohio-destroy: init
# 	 terraform workspace new ohio || terraform workspace select ohio && terraform destroy --auto-approve -var-file ../ENVS/us-east-2/ohio.tfvars

# california-destroy: init
# 	 terraform workspace new california || terraform workspace select california && terraform destroy --auto-approve -var-file ../ENVS/us-west-1/california.tfvars


# all: init
# 	 make ohio && make california 

# destroy-all: init
# 	 make ohio-destroy && make virginia-destroy && make california-destroy

# ohio-plan-1: init

# 		cd ../VPC/ && terraform workspace new ohio || terraform workspace select ohio && terraform plan  -var-file ../ENVS/us-east-2/ohio.tfvars

# 		cd ../ASG/ && terraform workspace new ohio || terraform workspace select ohio && terraform plan  -var-file ../ENVS/us-east-2/ohio.tfvars

# 		cd ../RDS/ && terraform workspace new ohio || terraform workspace select ohio && terraform plan  -var-file ../ENVS/us-east-2/ohio.tfvars