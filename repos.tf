module "make_test_repo_3" {
  source = "./modules/repo"

  token = var.token

  repo_name   = "test_repo_3"
  description = "testing edited terraform repo module"

  teams = {
    "team_1"        = "push"
    "team_2_manual" = "pull"
  }

  users = {
    "vinayakgajjewar" = "pull"
  }

}
