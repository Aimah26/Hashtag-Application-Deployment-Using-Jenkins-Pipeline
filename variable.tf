variable "vpc_name" {
  default            = "Hash-VPC"
}

variable "name" {
  default           = "Hash-App" 
}

variable "vpc_cidr" {
  default            = "10.0.0.0/16"
}

variable "az1" {
  default            = "eu-west-2a"
}

variable "az2" {
  default            = "eu-west-2b"
}

variable "prv-sn1" {
  default            = "10.0.1.0/24"
}

variable "prv-sn2" {
  default            = "10.0.2.0/24"
}

variable "pub-sn1" {
  default            = "10.0.3.0/24"
}

variable "pub-sn2" {
  default            = "10.0.4.0/24"
}

variable "http_port" {
  default            = 80
}


variable "ssh_port" {
  default            = 22
}

variable "proxy_port1" {
  default            = 8080
}

variable "proxy_port2" {
  default            = 9000
}

variable "MySQL_port" {
  default            = 3306
}

variable "des_http" {
  default            = "This port allows http access"   
}

variable "des_ssh" {
  default            = "This port allows ssh access"
}


variable "proxy" {
  default            = "This port allows proxy access"
}

variable "prot" {
  default            = "tcp"
}

variable "all_access" {
  default            = "0.0.0.0/0"
}

variable "keyname" {
  default            = "Hashkey"
}

variable "ec2_name" {
  default            = "Test-ec2"
}

variable "ec2_ami" {
  default            = "ami-05c96317a6278cfaa"
}

variable "instancetype" {
  default            = "t3.medium"  
  }

variable "sonar-name" {
  default            = "sonar-sever"
  }
variable "docker_name" {
  default            = "docker_server"
}