# VPC
module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  name                   = var.vpc_name
  cidr                   = var.vpc_cidr
  azs                    = [var.az1, var.az2]
  private_subnets        = [var.prv-sn1, var.prv-sn2]
  public_subnets         = [var.pub-sn1, var.pub-sn2]
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  tags = {
    Terraform = "true"
    Name      = "${var.name}-vpc"
  }
}

module "sg" {
  source   = "./local_module/sg"
  Hash-vpc = module.vpc.vpc_id
}

module "key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = var.keyname
  public_key = file("~/keypairs/Hashkey.pub")
}

module "Bastion" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.ec2_name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.bastion-sg-id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data = templatefile("./User_Data/bastion_userdata.sh",
    {
      keypair = "~/keypairs/Hashkey"
    }
  )
  tags = {
    Terraform = "true"
    Name      = "${var.name}-Bastion"
  }
}

module "Docker" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.ec2_name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.docker-sg-id]
  subnet_id              = module.vpc.private_subnets[0]
  count                  = 2
  user_data              = file("./User_Data/docker.sh")
  tags = {
    Terraform = "true"
    Name      = "${var.docker_name}${count.index}"
  }
}

module "Jenkins" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.ec2_name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.jenkins-sg-id]
  subnet_id              = module.vpc.private_subnets[0]
  user_data              = file("./User_Data/jenkins.sh")
  tags = {
    Terraform = "true"
    Name      = "${var.name}-Jenkins"
  }
}

module "jenkins_elb" {
  source      = "./local_module/jenkins_elb"
  subnet_id1  = module.vpc.public_subnets[0]
  subnet_id2  = module.vpc.public_subnets[1]
  security_id = module.sg.alb-sg-id
  jenkins_id  = module.Jenkins.id
}
module "Prod_elb" {
  source      = "./local_module/Prod_elb "
  subnet_id1  = module.vpc.public_subnets[0]
  subnet_id2  = module.vpc.public_subnets[1]
  security_id = module.sg.alb-sg-id
  jenkins_id  = module.Docker[1].id
}

module "Ansible" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.ec2_name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.ansible-sg-id]
  subnet_id              = module.vpc.private_subnets[0]
  user_data = templatefile("./User_Data/ansible.sh",
    {
      Stage-container      = "./playbooks/Stage.yml",
      Prod-container       = "./playbooks/Prod.yml",
      Stage_Server_priv_ip = module.Docker[1].private_ip,
      Prod_Server_priv_ip  = module.Docker[0].private_ip,
      keypair              = "~/keypairs/Hashkey"
    }
  )
  tags = {
    Terraform = "true"
    Name      = "${var.name}-Ansible"
  }
}
module "Sonarqube" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.sonar-name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.sonarqube-sg-id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("./User_Data/sonar.sh")
  tags = {
    Terraform = "true"
    Name      = "${var.name}-sonar-server"
  }
}

module "App_loadbalancer" {
  source          = "./local_module/App_loadbalancer"
  lb_security     = module.sg.alb-sg-id
  lb_subnet1      = module.vpc.public_subnets[0]
  lb_subnet2      = module.vpc.public_subnets[1]
  vpc_name        = module.vpc.vpc_id
  target_instance = module.Docker[1].id

}

module "Route53" {
  source     = "./local_module/Route53"
  lb_DNS     = module.App_loadbalancer.lb_DNS
  lb_zone_id = module.App_loadbalancer.lb_zone_id

}


# module "Auto_Scaling_Group" {
#  source = "./local_module/Auto_Scaling_Group"
#  vpc_subnet1 = module.vpc.public_subnets[0]
#  vpc_subnet2 = module.vpc.public_subnets[1]
#  lb_arn = module.App_loadbalancer.lb_arn
#  asg_sg = module.sg.docker-sg-id
#  key_pair = module.key_pair.key_pair_name
#  ami_source_instance = module.Docker[1].id

# }



