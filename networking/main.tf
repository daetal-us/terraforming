# aws
provider "aws" {
  region = "${var.region}"
}

# instance
resource "aws_instance" "main" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.main.id}"
  vpc_security_group_ids = ["${aws_security_group.main.id}"]
  subnet_id = "${aws_subnet.public.id}"
}

# copy instantiator's public key
resource "aws_key_pair" "main" {
   key_name = "instantiator"
   public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# network security: (out -> all | in <- http, ssh)
resource "aws_security_group" "main" {
  vpc_id = "${aws_vpc.main.id}"
  name = "ssh-http"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

# elastic ip
resource "aws_eip" "main" {
  instance = "${aws_instance.main.id}"
}

# output
output "ip" {
  value = "${aws_eip.main.public_ip}"
}
