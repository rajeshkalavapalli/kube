module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "eks-works"
  ami = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
#   key_name               = "user1"
#   monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_eksctl.id]
  subnet_id              = "subnet-043091cc04d94c6a7"
  user_data = file("workstation.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


resource "aws_security_group" "allow_eksctl" {
  name        = "allow_eksctl"
  description = "created for eksctl"
  

  tags = {
    Name = "allow_eksctl"
  }

  ingress {
   description = "HTTPS ingress"
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}

data "aws_ami" "centos8" {
owners           = ["973714476881"]
most_recent      = true

    filter {
        name   = "name"
        values = ["Centos-8-DevOps-Practice"]
    }

    #  filter {
    #      name   = "root-device-type"
    #      values = ["EBS"]
    # }

    #  filter {
    #      name   = "virtualization-type"
    #      values = ["hvm"]
    #  }

}

