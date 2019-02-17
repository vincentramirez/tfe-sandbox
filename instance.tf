provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "ec2_vm" {
  count = "1"
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  volume_size   = "${var.instance_size}"
  # the VPC subnet
  subnet_id = "${aws_subnet.subnet-public-1a.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.secgroup.id}"]

  # SSH key in AWS account
  key_name = "${var.ssh_key}"
 
  # tags
  tags {
    Name = "ec2-${count.index}-${var.environment_name}"
    owner = "${var.owner}"
    TTL = "${var.ttl}"
  }
}
                  
