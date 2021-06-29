terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

variable "token" {
  type = string
}

# Configure the GitHub Provider
provider "github" {
  token = var.token
  owner = "jay-feng-org"
}
