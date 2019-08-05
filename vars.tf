variable "aws_region" {
    default = "us-east-1"
}
variable "aws_access_key_id" {}
variable "aws_secret_access_key" {}
variable "aws_zones" {
 type        = "list"
 description = "List of availability zones to use"
 default     = ["us-east-1c", "us-east-1d", "us-east-1e"]
}

variable "private_key_path" {
    default = "ec2keys.pem"
}

#must have key name if you want to be able to connect to instance
#also looks like the key has to be created in AWS first (Network & Security -> Key Pairs)
variable "key_name" {  
  default = "ec2keys"
}