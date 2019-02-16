# VPC with internet gateway

resource "aws_vpc" "vpc" {
    cidr_block = "11.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "${var.environment_name}-vpc"
    }
}


# Subnets
resource "aws_subnet" "subnet-public-1a" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags {
        Name = "${var.environment_name}-public-subnet-1a"
    }
}
resource "aws_subnet" "subnet-public-2b" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags {
        Name = "${var.environment_name}-public-subnet-2b"
    }
}
resource "aws_subnet" "subnet-public-3c" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1c"

    tags {
        Name = "${var.environment_name}-public-subnet-3c"
    }
}
resource "aws_subnet" "subnet-private-1a" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags {
        Name = "${var.environment_name}-private-subnet-1a"
    }
}
resource "aws_subnet" "subnet-private-2b" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "${var.environment_name}-private-subnet-2b"
    }
}
resource "aws_subnet" "subnet-private-3c" {
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "11.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1c"

    tags {
        Name = "${var.environment_name}-private-subnet-3c"
    }
}

# Internet GW
resource "aws_internet_gateway" "internet-gateway" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags {
        Name = "${var.environment_name}-internet-gw"
    }
}

# route tables
resource "aws_route_table" "public-rt" {
    vpc_id = "${aws_vpc.vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.internet-gateway.id}"
    }

    tags {
        Name = "${var.environment_name}-public-route"
    }
}

# route associations public
resource "aws_route_table_association" "public-1a" {
    subnet_id = "${aws_subnet.subnet-public-1a.id}"
    route_table_id = "${aws_route_table.public-rt.id}"
}
resource "aws_route_table_association" "public-2b" {
    subnet_id = "${aws_subnet.subnet-public-2b.id}"
    route_table_id = "${aws_route_table.public-rt.id}"
}
resource "aws_route_table_association" "subnet-public-3a" {
    subnet_id = "${aws_subnet.subnet-public-3c.id}"
    route_table_id = "${aws_route_table.public-rt.id}"
}
