variable "team_name" {
  type = string
}

variable "repo_name" {
  type = string
}

resource "github_repository" "some_repo" {
  name = var.repo_name
}

resource "github_team_repository" "some_team_repo" {
  team_id = var.team_name
  repository = github_repository.some_repo.name
  permission = "pull"
}
