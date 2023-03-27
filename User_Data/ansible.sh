#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo yum update -y
sudo yum install python3-pip -y
sudo pip3 install boto boto3 botocore 
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo yum update -y 
sudo yum install git python python-devel python-pip ansible -y
sudo chown ec2-user:ec2-user /etc/ansible/hosts
sudo chown -R ec2-user:ec2-user /etc/ansible && chmod +x /etc/ansible
sudo chmod 777 /etc/ansible/hosts
sudo bash -c 'echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'
sudo mkdir /home/ec2-user/playbooks
sudo echo "${file(Stage-container)}" >> /home/ec2-user/playbooks/Stage-container.yml
sudo echo "${file(Prod-container)}" >> /home/ec2-user/playbooks/Prod-container.yml  
sudo echo "[Stage_Server]" >> /etc/ansible/hosts
sudo echo "${Stage_Server_priv_ip} ansible_user=ec2-user  ansible_ssh_private_key_file=/home/ec2-user/Hashkey" >> /etc/ansible/hosts
sudo echo "[Prod_Server]" >> /etc/ansible/hosts
sudo echo "${Prod_Server_priv_ip} ansible_user=ec2-user  ansible_ssh_private_key_file=/home/ec2-user/Hashkey" >> /etc/ansible/hosts
sudo chmod 400 /home/ec2-user/paceud-kp2   
echo "license_key: eu01xxbca018499adedd74cacda9d3d13e7dNRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y --nobest
echo "${file(keypair)}" >> /home/ec2-user/Hashkey
chmod 400 /home/ec2-user/Hashkey
sudo hostnamectl set-hostname ansible

