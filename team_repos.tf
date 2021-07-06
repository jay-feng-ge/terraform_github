module "make_team_1_test_repo" {
  source = "./modules/team_repo"

  token = var.token

  team_name = "team_1"
  repo_name = "team_1_test_repo"
}

module "make_team_1_test_repo_2" {
  source = "./modules/team_repo"

  token = var.token

  team_name = "team_1"
  repo_name = "team_1_test_repo_2"
}
