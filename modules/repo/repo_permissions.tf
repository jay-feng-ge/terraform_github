# THIS FILE WILL CREATE TEAM PERMISSION RESOURCES AND USER
# PERMISSION RESOURCES FOR THE REPO CREATE FROM THIS MODULE

variable "teams" {
  type = map
}

variable "users" {
  type = map
}

resource "github_team_repository" "some_teams" {
  repository = github_repository.some_repo.name

  for_each = var.teams
  team_id = each.key
  permission = each.value
}

resource "github_repository_collaborator" "some_users" {
  repository = github_repository.some_repo.name

  for_each = var.users
  username = each.key
  permission = each.value
}
