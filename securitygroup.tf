resource "aws_security_group" "secgroup" {
  vpc_id = "${aws_vpc.vpc.id}"
  name = "${var.environment_name}-secgroup"
  description = "security group all egress, ingress only from laptop"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["${var.my_ip}"]
  } 
tags {
    Name = "allow-ssh from trusted ip or CIDR"
  }

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["${aws_security_group.secgroup.id}"]
  }
tags {
    Name = "allow-all from SG"
  } 
 

  
}
