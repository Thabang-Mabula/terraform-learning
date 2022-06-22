# Remember: This file is executed in a declaritive fashion. That means that if we run it more than once
#           then we won't neccesarily be dubplicating the setup described here. Terraform will instead
#           look at our existing setup, and then compare it to the setup we've described here.
#           If the setups are the same, then no changes will be made. 

# Also note: This file doesn't get executes in a sequencial, imperative manner. As such, the order of
#             th code doesn't really matter

# To execute this file, run "terraform apply". If you want to override the confirmation prompt, 
# run "terraform apply --auto-approve"

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

# This part is in the format:
# resource "<provider>_<resource_type>" "name"
# if you want to destroy this instance, run "terraform destroy"
# alternatively, just remove this from the TF file
resource "aws_instance" "terraform_aws_instance" { # you can get prperties from this config in other parts of the script by referencing aws_instance.terraform_aws_instance.<property_name>
    # For docs on how to configure this, visit https://registry.terraform.io/providers/hashicorp/aws/2.36.0/docs/resources/instance
    ami = "ami-0d9c8c63d814416d6"
    instance_type = "t3.micro"

    tags = {
      Name = "my-terraform-ec2-instance"
    }
    
}