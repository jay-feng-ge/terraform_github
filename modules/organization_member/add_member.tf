variable "username" {
  type = string
}

variable "role" {
  type = string
}

resource "github_membership" "membership_for_some_user" {
  username = var.username
  role = var.role
}
