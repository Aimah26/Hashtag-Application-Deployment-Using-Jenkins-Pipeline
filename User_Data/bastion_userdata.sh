#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "${file(keypair)}" >> /home/ec2-user/Hashkey
chmod 400 /home/ec2-user/Hashkey
sudo hostnamectl set-hostname bashion