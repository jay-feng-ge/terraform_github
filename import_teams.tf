module "make_team_2" {
  source = "./modules/team"

  token       = var.token
  name        = "team_2_manual"
  privacy     = "secret"
  description = "terraform import test team"

  usernames = ["jay-feng", "jay-feng-ge"]
}

