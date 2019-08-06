# Docker via Terraform and AWS
1. Create AWS account
2. [Create IAM user](https://console.aws.amazon.com/iam/home) with admin privleges
   -  Create a key pair called ec2keys and save ec2keys.pem to this project location
3. Clone Repo and run terraform init
   ```
   git clone https://github.com/CushItRealGood/terraform-docker.git
   cd ./terraform-docker
   terraform init
   ```
4. Edit and rename secret.tfvars.example to secret.tfvars, input your IAM user key and secret and run the following:
   ```
   terraform plan -var-file='secret.tfvars'
   terraform apply -var-file='secret.tfvars' -auto-approve
   ```
5. Log into AWS by using the output value of 'aws_instance_public_dns'
   ```
   ssh -i <key location> admin@<ec2 public dns entry>
   example:
   ssh -i ec2keys.pem admin@ec2-52-234-127-217.compute-1.amazonaws.com
   ```
   
## Reference Materials:
 - Reviewed this [blog](https://blog.codeship.com/terraforming-your-docker-environment-on-aws/) by Phillip Shipley
 - Also watched some of Ned Bellavance [Getting Started with Terraform](https://app.pluralsight.com/library/courses/terraform-getting-started) on Pluralsite
