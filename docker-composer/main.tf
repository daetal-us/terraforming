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
  user_data = "${file("init.sh")}"
}

# copy instantiator's public key
resource "aws_key_pair" "main" {
   key_name = "instantiator"
   public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# network restrictions
resource "aws_security_group" "main" {
  name = "ssh-only"
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
      cidr_blocks = ["0.0.0.0/0"]
  }
}

# output
output "ip" {
  value = "${aws_instance.main.public_ip}"
}
