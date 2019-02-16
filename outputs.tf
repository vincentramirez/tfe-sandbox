output "instance_dns" {
  value = "${aws_instance.ec2_vm.public_dns}"
}

output "instance_public_ip" {
  value = "${aws_instance.ec2_vm.public_ip}"
}
