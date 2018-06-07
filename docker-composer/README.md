# Terraforming: Docker Composer

This configuration creates an EC2 instance using the Amazon Linux AMI with the following features:
- [Docker](//docker.com) and [Docker Compose](https://github.com/docker/compose) installed via [`init.sh`](init.sh)
- All outbound network traffic permitted
- Inbound `tcp` traffic to port `22` permitted (`ssh`)
- Default public key (`~/.ssh/id_rsa.pub`) copied to host.


Additionally, [`cmd/deploy.sh`](cmd/deploy.sh) demonstrates one approach to copying compose files to host and starting containers.
