# Terraforming: Networking

This configuration creates an EC2 instance using the Amazon Linux AMI with the following features:
- An [Elastic IP](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html)
- All outbound network traffic permitted
- Inbound `tcp` network traffic for `ssh` (22) and `http` (80/443) permitted
- Default public key (`~/.ssh/id_rsa.pub`) copied to host.
- A [Virtual Private Cloud](https://aws.amazon.com/vpc/) [configuration](vpc.tf) including custom `public` and `private` subnets
