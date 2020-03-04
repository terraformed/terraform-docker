# Docker via Terraform on AWS
 This project will leverage AWS to quickly land a debian ec2 instance with docker installed. A security group with ports 22, 80, and 443 allowed inbound are created on terraform apply as well. This instance should be free for 12 months if done with AWS free tier.

### Prerequisites
Install Terraform and Git. I suggest using chocolatey for Windows or homebrew for Mac. 

## Getting Started
1. Create AWS account
2. [Create IAM user](https://console.aws.amazon.com/iam/home)
   - Select Programmatic access for access type
   - Give the user 'AdministratorAccess' policy or create a Admin group with 'AdministratorAccess' and add that user to it.
   - After creating the user you will get the access key ID and secret access key. You will need these for our secret.tfvars file.
3. [Create a key pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) called ec2keys and save subsequent ec2keys.pem to this project location. The key pair is region specific so make sure it is created in the right place (us-east-1).
4. In order to use this AWS Marketplace product you need visit [here](https://aws.amazon.com/marketplace/pp?sku=55q52qvgjfpdj2fpfy9mb1lo4), click "Continue to Subscribe", and accept the terms of service.

## Installation
1. Clone Repo and run terraform init
   ```
   git clone https://github.com/terraformed/terraform-docker.git
   cd ./terraform-docker
   terraform init
   ```
2. Rename secret.tfvars.example to secret.tfvars and input your IAM user key and secret key from earlier

3. Build the environment using Terraform:
   ```
   terraform plan -var-file='secret.tfvars'
   terraform apply -var-file='secret.tfvars' -auto-approve
   ```
4. Log into AWS by using the output value of 'aws_instance_public_dns'
   ```
   ssh -i <key location> admin@<ec2 public dns entry>
   example:
   ssh -i ec2keys.pem admin@ec2-52-234-127-217.compute-1.amazonaws.com
   ```
## Known Issues
AMI errors can occur because the debian image is no longer available, the work around would be to find the updated image id from [here](https://wiki.debian.org/Cloud/AmazonEC2Image/Stretch) and replace the ami_id variable in the vars.tf file.

## Acknowledgments
 - Referenced this [blog](https://blog.codeship.com/terraforming-your-docker-environment-on-aws/) by Phillip Shipley
 - Watched some of Ned Bellavance [Getting Started with Terraform](https://app.pluralsight.com/library/courses/terraform-getting-started) on Pluralsite
