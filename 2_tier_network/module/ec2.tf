module "bastion_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "bastion_ec2"

  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name  =  "ubuntukey"
  associate_public_ip_address = true
  monitoring             = true
  vpc_security_group_ids = [ module.public_sg.security_group_id ]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Name = "upgrad-bastion-ec2"
    Terraform = "managedbyTerraform"
  }
}

module "jenkins_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins_ec2"

  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name  =  "ubuntukey"
  monitoring             = true
  vpc_security_group_ids = [ module.private_sg.security_group_id ]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Name = "upgrad-jenkinsn-ec2"
    Terraform = "managedbyTerraform"
  }
}

module "app_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "app_ec2"

  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  key_name  =  "ubuntukey"
  monitoring             = true
  vpc_security_group_ids = [ module.private_sg.security_group_id ]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Name = "upgrad-app-ec2"
    Terraform = "managedbyTerraform"
  }
}