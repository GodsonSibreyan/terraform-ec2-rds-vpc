Step1: Clone the terraform repository to build aws stack. 
git clone https://github.com/GogineniManojkumar/terraform-ec2-rds-vpc.git

Step2: Modify the below variables in the variables.tf file 
1. keypair
2. dbusername
3. dbpassword

Step3: create aws iam access keys with ec2,iam,rds,vpc full access in order to provision the stack. Update the access key and secret key in the terraform.tfvars file.

aws_access_key = " "

aws_secret_key = " "

Step4: Now you can provision the stack using terrform. Please run below commands. 

#terraform init   (It initalize the code )

#terraform plan   (It show which resources going to provision in aws)

#terraform apply  ( To provison the stack in aws)

above commands will provison the stack in aws. It takes 10-15 minutes to complete.

Note: We are doing the wordpress and server configuration using ansible playbook. We are running the ansible playbook using the userdata. (https://github.com/GogineniManojkumar/wp-ansible.git) 

Step5: Once you are done with stack provision. please access the wordpress with ELB dns. (you can find the elb dns in terraform outputs)


Step6: We are done with stack creation and setup. If you would like to terminate please run below command to terminate the stack which you created using terraform. 

#terraform destroy    (To delete the resources)

