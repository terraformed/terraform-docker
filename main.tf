#Storing just resources in main.tf

resource "aws_security_group" "docker-terraformed-sg" {
  name        = "docker-terraformed_sg"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "docker-terraformed" {
  ami           = "ami-08e053c0dc7059edf" # This ami is for Debian OS, you could also use ami-c58c1dd3 is the free Amazon Linux AMI but I believe its based on RHEL so remote-exec commands may fail
  instance_type = "t2.micro"
  key_name        = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.docker-terraformed-sg.id}"]

  connection {
    host        = self.public_ip #did not see this in documentation but found solution here: https://github.com/hashicorp/terraform/issues/20816
    user        = "admin" #ec2-user is the default user for aws and admin is default for debian
    private_key = "${file(var.private_key_path)}"
  }

  # docker installer file to aws instance
  provisioner "file" {
    source      = "scripts/"
    destination = "/home/admin/"
  }
  provisioner "remote-exec" {
    inline = [

      #prepping for traefik later, optional and unncessary for most users
      "touch acme.json",
      "chmod 600 acme.json",

      #Install Docker and Docker Compose
      "sudo chmod 700 install_docker.sh",
      "./install_docker.sh"

      
    ]
  }
}
