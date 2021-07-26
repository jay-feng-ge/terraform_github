variable "deploy_keys" {
  type = list
  default = []
}

resource "github_repository_deploy_key" "some_repo_deploy_key" {
  repository = github_repository.some_repo.name

  for_each = {for deploy_key in var.deploy_keys:  deploy_key.id => deploy_key}
  title = each.value.title
  key = each.value.key
  read_only = each.value.read_only
}
