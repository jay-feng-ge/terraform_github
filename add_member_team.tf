resource "github_team_membership" "team_membership_for_some_user" {
  team_id = github_team.terraform_team_test.id
  username = "jay-feng"
  role = "member"
}
