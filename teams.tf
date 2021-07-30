module "make_team_1" {
  source = "./modules/team"

  token = var.token

  name        = "team_1"
  description = "terraform test team called team_1"

  usernames = ["jay-feng", "jay-feng-ge"]
}

module "make_team_2" {
  source = "./modules/team"

  token = var.token

  name        = "team_2"
  description = "terraform test team called team_2"

  usernames = ["jay-feng"]
}
