terraform {
  required_providers {
    github = {
      source = "integrations/github"
      # For production environments, the versioning is very important. If a version isn't specified,
      # Terraform will naturally use the latest version.configuration_aliases.configuration_aliases
      # Therefore, to ensure consistancy and reduce potential drama in prod, it's good practice to explicitely
      # specify a version (and not a version range like ~>)
      version = "4.26.1"
    }
  }
}

provider "github" {
  token =  "" 

}

resource "github_repository" "terra-repo" {
  name        = "terraform-learning"
  description = "Repo with various scripts that I've developed during the learning journey"

  visibility = "public"
}