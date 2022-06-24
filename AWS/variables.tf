# This file allows you to export variables that can be used in your main.tf file

variable "inbound_http_cidr_blocks" {
  # this is the value that Terraform is going to use if you haven't explicitely set any values
  default = ["0.0.0.0/0"]
  # it's good practice to specify the variable type for other people who're reading or using your setup
  type = list(string)
}

variable "inbound_https_cidr_blocks" {
  default = ["0.0.0.0/0"]
  type    = list(string)
}

variable "inbound_ssl_cidr_blocks" {
  default = ["0.0.0.0/0"]
  type    = list(string)
}

variable "outbound_cidr_blocks" {
  default = ["0.0.0.0/0"]
  type    = list(string)
}

variable "private_key_path" {
  default = ""
  type = string
}