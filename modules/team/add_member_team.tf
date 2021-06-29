variable "usernames" {
  type = list
}

resource "github_team_membership" "team_member" {
  for_each = toset(var.usernames)
  username = each.key

  team_id = github_team.some_team.id
  role = "member"
}
