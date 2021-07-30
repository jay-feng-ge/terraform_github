module "add_vinayakgajjewar" {
  source = "./modules/organization_member"

  token = var.token

  username = "vinayakgajjewar"
  role     = "member"
}
