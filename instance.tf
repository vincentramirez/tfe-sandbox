#comment to trigger a run 
provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "ec2_vm" {
  count = "${var.count}"
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  root_block_device {
  #volume_type = "gp2"
  volume_size = "${var.instance_size}"
  delete_on_termination = "true"
  } 
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
                  
