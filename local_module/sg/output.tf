output "ansible-sg-id" {
  value = aws_security_group.Hash_Ansible_SG.id
}

output "docker-sg-id" {
  value = aws_security_group.Hash_Docker_SG.id
}

output "jenkins-sg-id" {
  value = aws_security_group.Hash_Jenkins_SG.id
}

output "sonarqube-sg-id" {
  value = aws_security_group.Hash_Sonarqube_SG.id
}

output "mysql-sg-id" {
  value = aws_security_group.Hash_DB_Backend_SG.id
}

output "alb-sg-id" {
  value = aws_security_group.Hash_ALB_SG.id
}

output "bastion-sg-id" {
  value = aws_security_group.Hash_bastion_SG.id
}

