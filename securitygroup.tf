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
      cidr_blocks = ["98.228.185.91/32"]
  } 
tags {
    Name = "allow-ssh from my laptop"
  }

/*
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags {
    Name = "allow-HTTP"
  } */ 

}
