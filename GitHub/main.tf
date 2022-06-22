terraform {
  required_providers {
    github = {
      source = "integrations/github"
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