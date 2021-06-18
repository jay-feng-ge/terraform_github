resource "github_team_membership" "terraform_team_repo_test" {
  team_id = github_team.terraform_team_test.id
  username = "jay-feng"
  role = "member"
}
