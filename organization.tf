module "add_jay" {
  source = "./modules/organization_member"

  token = var.token

  username = "jay-feng"
  role = "member"
}
