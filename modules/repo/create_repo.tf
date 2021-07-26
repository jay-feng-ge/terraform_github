# imported variables from module call:
# repo name (one)
# team names (multiple)
# user names (muliple)

# THIS FILE WILL CREATE A REPO WITH BRANCH PROTECTION

variable "repo_name" {
  type = string
}

variable "description" {
  type = string
  default = null
}

variable "visibility" {
  type = string
  default = "private"
}

variable "allow_merge_commit" {
  type = string
  default = false
}

variable "auto_init" {
  type = bool
  default = true
}

resource "github_repository" "some_repo" {
  name = var.repo_name
  description = var.description
  visibility = var.visibility
  allow_merge_commit = var.allow_merge_commit
  auto_init = var.auto_init
}
