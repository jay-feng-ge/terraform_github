resource "github_team" "terraform_team_test" {
  name = "terraform_team_test"
  description = "test team created with terraform"
  privacy = "closed"
}

resource "github_repository" "terraform_repo_test" {
  name = "terraform_repo_test"
)


rsource "github_team_repository" "terraform_team_repo_test" {
  team_id = github_team.some_team.id
  repository = github_repository.terraform_repo_test.name
  permission = "pull"
}
