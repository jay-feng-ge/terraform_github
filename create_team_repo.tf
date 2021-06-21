resource "github_repository" "team_repo_test" {
  name = "team_repo_test"
}

resource "github_team_repository" "some_team_repo" {
  team_id = github_team.terraform_team_test.id
  repository = github_repository.team_repo_test.id
  permission = "push"
}
