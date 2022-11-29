module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Name = "upgrad-vpc"
    Terraform = "managedbyTerraform"
  }
}

module "public_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name = "upgrad-public-sg"
  description = "public security group"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name = "upgrad-public-sg"
    Terraform = "managedbyTerraform"
  }
}

module "private_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name = "upgrad-private-sg"
  description = "public security group"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    Name = "upgrad-private-sg"
    Terraform = "managedbyTerraform"
  }
}