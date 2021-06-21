resource "github_team" "terraform_team_test" {
  name = "terraform_team_test"
  description = "test team created with terraform"
  privacy = "closed"
}
