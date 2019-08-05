output "aws_instance_public_dns" {
    value = "${aws_instance.docker-terraformed.public_dns}"
}