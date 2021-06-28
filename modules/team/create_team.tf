variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "privacy" {
  type = string
  default = "secret"
}

resource "github_team" "some_team" {
  name = var.name
  description = var.description
  privacy = var.privacy
}
