module "make_team_1_test_repo" {
  source = "./modules/repo"

  token = var.token

  repo_name          = "team_1_test_repo"
  description        = "null"
  visibility         = "public"
  allow_merge_commit = "true"

  users = {
    "jay-feng-ge" = "admin"
  }

  teams = {
    "team_1" = "pull"
  }
}
