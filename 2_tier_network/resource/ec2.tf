module "public_ec2_instance" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    version = "~> 3.0"
    
    name = "public-instance"

    ami                    = "ami-08c40ec9ead489470"
    instance_type          = "t2.micro"
    key_name               = "ubuntukey"
    monitoring             = true
    vpc_security_group_ids = [module.ssh_sg.security_group_id]
    subnet_id              = module.vpc.public_subnets[0]
  
    tags = {
        Terraform   = "true"
        Environment = "dev"
    }
}


module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "ubuntu"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCltMVzwOlM4VOTntn7DOeTznmHZJ3mQlCLCOFMhUbV+YFuj1qMqDM5/p1OceVtSmPxqp9mTsA9e76fn6ElmHPrFW7Wexc4d1RiN+f6ZHSn2hFDuquWAYseVyTzyw70cStQw4jnCcL3kxCJ2XJCn84yEGEeLr/Q03G93lyHjUMLMy74Adsva3bRKS0aeCVlVbmbxBIIjN228MWkTZu313NNwsAigNuxd/A69ZhrVBovQEqx+W+KSqRDtXVbW0Z2inbF9dSLQGwGvmZSNUYo/cvXR/gIVjY2r9ZT2Xi1vE2idEPZvDf/N/YGoitnqHqOyqh6mHP5E6YyThv//ytK3X5K5rL69/76xSblly4PP4FV+S2Bh8w0xQVpsszuu46UcBZa53kwMhvVGf3xHl+NKnCZaWsfMlu19v6GNjOpTF0b39J9BrLk5aMEZNt8ygJihApZ2wT/P9WpAe2n00c0g8Js6aKyvMfTCxVuRtiH3ZgNC8titfr7fIYUIwaXeoaaobE= ubuntu@ip-10-0-101-252"
}


module "private_ec2_instance" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    version = "~> 3.0"

    name = "private-instance"

    ami                    = "ami-08c40ec9ead489470"
    instance_type          = "t2.micro"
    key_name               = "ubuntu"
    monitoring             = true
    vpc_security_group_ids = [module.ssh_sg.security_group_id]
    subnet_id              = module.vpc.private_subnets[0]

    tags = {
        Terraform   = "true"
        Environment = "dev"
    }
}
