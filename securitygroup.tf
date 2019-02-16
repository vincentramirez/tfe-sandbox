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

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags {
    Name = "allow-HTTP"
  } 
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags {
    Name = "allow-https"
  } 
  ingress {
      from_port = 8800
      to_port = 8800
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
tags {
    Name = "pTFE Admin"
  } 
ingress {
      from_port = 23000
      to_port = 23100
      protocol = "tcp"
      cidr_blocks = ["${aws_security_group.secgroup.id}"]
  }
tags {
    Name = "ptfe-containers-internal"
  } 
ingress {
      from_port = 9870
      to_port = 9880
      protocol = "tcp"
      cidr_blocks = ["${aws_security_group.secgroup.id}"]
  }
tags {
    Name = "ptfe-containers-internal"
  } 

  
}
