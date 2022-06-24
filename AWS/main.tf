/* 
Remember: This file is executed in a declaritive fashion. That means that if we run it more than once
          then we won't neccesarily be dubplicating the setup described here. Terraform will instead
           look at our existing setup, and then compare it to the setup we've described here.
           If the setups are the same, then no changes will be made. 
*/

/*
Also note: This file doesn't get executes in a sequencial, imperative manner. As such, the order of
             the code doesn't really matter
*/

/*
To execute this file, run "terraform apply". If you want to override the confirmation prompt, 
    run "terraform apply --auto-approve"
*/

# This block lets you set terrform-related settings and constraints
terraform {
  required_version = "> 0"
  
}


# You can get more info on how to setup configs at https://www.terraform.io/language/providers
# You can see a full list of the Terraform providers at https://registry.terraform.io/browse/providers
# If you're working a provider that isn't maintained by HashiCorp, you'll have to specify it in 
# the "required_providers" block in the "terraform" configuration block. You can copy/paste that
# from the "USE PROVIDER" button in the docs
provider "aws" { #  local name of the provider to configure
  region = "af-south-1"
  # Find more configuration methods at https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration
  access_key = ""
  secret_key = ""
}

# This is a nice block where you can add local variables (or more specifically, constants) that get
# re-used multiple times throughout your code
# For more info on how to use these, go to https://www.terraform.io/language/values/locals
locals {
  # A bad example of when to use locals, but hey, this file is for demonstration purposes only
  ec2_name = "my-terraform-ec2-instance"
}


# Allows you to look up config values from a data-source
data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }
}

# This part is in the format:
# resource "<provider>_<resource_type>" "name"
# if you want to destroy this instance, run "terraform destroy -target aws_instance.terraform_aws_instance"
# alternatively, just remove this from the TF file
resource "aws_instance" "terraform_aws_instance" {
  # you can get properties from this config in other parts of the script by referencing aws_instance.terraform_aws_instance.<property_name>
  # the general format for referencing is <resource-type>.<local_resource_name>
  # For docs on how to configure this, visit https://registry.terraform.io/providers/hashicorp/aws/2.36.0/docs/resources/instance
  ami           = data.aws_ami.ami.id
  instance_type = "t3.micro"
  tags = {
    Name = local.ec2_name
  }

  vpc_security_group_ids = [aws_security_group.default_ec2_security_group.id]

  key_name = "my-new-pem-keypair"

  
  connection {
    type     = "ssh"
    user     = "ec2-user"
    # Here we're using the "file" function to get the private key for the SSH connection
    # To see more functions, refer to https://www.terraform.io/language/functions
    private_key = "${file(var.private_key_path)}"
    host     = self.public_ip
  }

  # Here we're running a command in the instance that installs and runs an Apache2 server.
  # Although we could've added this to the user-data, we did it this way
  # to show how we can remotely execute bash commands in our remote server. 
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
    ]
  }

  # If you wanted to create multiple instances, instead of copy/pasting, you can use count, e.g.:
  # count = 5
  # Will create 5 instances. Furthermore, you can access the index of the instance by using count.index
  # (this is especially helpful when naming your instances)

}

resource "aws_security_group" "default_ec2_security_group" {
  name        = "Generic EC2 Secuirty Group"
  description = "Allows HTTP, HTTPS and SSH access"

  ingress {
    description = "HTTP from any source"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.inbound_http_cidr_blocks
  }

  ingress {
    description = "HTTPS from any source"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.inbound_https_cidr_blocks
  }

  ingress {
    description = "SSL from any source"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.inbound_ssl_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.outbound_cidr_blocks
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_eip" "ec2_eip" {
  instance = aws_instance.terraform_aws_instance.id
  vpc      = true
}



#  Outputs the specified value to the console when the file is applied
#  Expected format: ec2_ip = <public_ip_address>
#  You can find the rest of the attribute values that we can display for this
#  instance under the "Attributes Reference" part of the docs (e.g. https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attributes-reference) 
output "ec2_ip" {
  value = aws_instance.terraform_aws_instance.public_ip
}

output "ec2_elastic_ip" {
  value = aws_eip.ec2_eip.address
}

output "ami_id" {
  value = data.aws_ami.ami.id
}
