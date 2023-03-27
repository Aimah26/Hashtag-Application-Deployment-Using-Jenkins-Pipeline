output "vpc_id" {
  value  = module.vpc.vpc_id
}

output "Bastion_ip" {
  value  = module.Bastion.public_ip
}

output "Docker_ip" {
  value  = module.Docker.*.private_ip
}

output "Jenkins-ip" {
  value = module.Jenkins.private_ip
}

output "jenkins-elb-dns" {
  value = module.jenkins_elb.jenkins_elb_dns
}

output "prod_elb_dns" {
  value = module.Prod_elb.prod_elb_dns
}

output "Sonar-pub_ip" {
  value = module.Sonarqube.public_ip
}
output "Ansible-ip" {
  value = module.Ansible.private_ip
}

output "lb_DNS" {
  value = module.App_loadbalancer.lb_DNS
}



# output "vpc_id" {
#     value = aws_vpc.PACEUD_VPC.id
# }

# output "pubsn1-id" {
#   value = aws_subnet.PACEUD_Pub_SN1.id
# }

# output "pubsn2-id" {
#   value = aws_subnet.PACEUD_Pub_SN2.id
# }
# output "prvsn1-id" {
#   value = aws_subnet.PACEUD_Priv_SN1.id
# }

# output "prvsn2-id" {
#   value = aws_subnet.PACEUD_Priv_SN2.id
# }