
#Create Security Group for Ansible
resource "aws_security_group" "Hash_Ansible_SG" {
  name        = "${var.name}-Ansible-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.Hash-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Ansible_SG"
  }
}

#Create Security Group for Docker
resource "aws_security_group" "Hash_Docker_SG" {
  name        = "${var.name}-Docker-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.Hash-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port2
    to_port     = var.proxy_port2
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Docker_SG"
  }
}

#Create Security Group for Jenkins
resource "aws_security_group" "Hash_Jenkins_SG" {
  name        = "${var.name}-Jenkins-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.Hash-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Jenkins_SG"
  }
}

#Create Security Group for Sonarqube
resource "aws_security_group" "Hash_Sonarqube_SG" {
  name        = "${var.name}-Sonarqube-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.Hash-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port2
    to_port     = var.proxy_port2
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-Sonarqube_SG"
  }
}

#Create Security Group for LC ALB
resource "aws_security_group" "Hash_ALB_SG" {
  name        = "${var.name}-ALB-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.Hash-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow proxy access"
    from_port   = var.proxy_port1
    to_port     = var.proxy_port1
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-ALB_SG"
  }
}

#Create Security Group for Bastion
resource "aws_security_group" "Hash_bastion_SG" {
  name        = "${var.name}-bastion-sg"
  description = "Allow Inbound traffic"
  vpc_id      = var.Hash-vpc

  ingress {
    description = "Allow ssh access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

    ingress {
    description = "Allow inbound traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-bastion_SG"
  }
}

#Backend SG - Database 
resource "aws_security_group" "Hash_DB_Backend_SG" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.Hash-vpc

  ingress {
    description = "MYSQL_port"
    from_port   = var.MYSQL_port
    to_port     = var.MYSQL_port
    protocol    = "tcp"
    cidr_blocks = [var.all_access]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_access]
  }

  tags = {
    Name = "${var.name}-DB_Backend_SG"
  }
}


