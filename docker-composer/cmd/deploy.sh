#!/bin/sh

IP="$(terraform output ip)"
HOST=ec2-user@${IP}

ssh $HOST 'docker-compose down'
scp docker-compose.yml $HOST:docker-compose.yml
ssh $HOST 'docker-compose up'
