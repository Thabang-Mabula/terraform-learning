# This file let's you override the default values of your variables in the variables.tf file

# Expressing variables in this file helps you to avoid the repetitive task of manually entering these variables into the
# command line (e.g. terraform plan -var="inbound_http_cidr=0.0.0.0/0" or setx in Windows terminal)

# If you'd like to use a custom file (e.g. myterra.tfvars), then you'd have to specify it in the command line
# when running your terraform commands using -var-file="myterra.tfvars"

inbound_http_cidr_blocks  = ["0.0.0.0/0"]
inbound_https_cidr_blocks = ["0.0.0.0/0"]
inbound_ssl_cidr_blocks   = ["0.0.0.0/0"]
outbound_cidr_blocks      = ["0.0.0.0/0"]

private_key_path =  ""