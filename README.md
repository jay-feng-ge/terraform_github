# terraform_github_teams
Dockerized Terraform Script to manage github teams and team repos

Build Docker Image
```
docker build --tag dockerized_tf_github_repo .
```

Runs `terraform init` in the Docker Container
```
docker run -v `pwd`:/workspace -w /workspace hashicorp/terraform:light init
```

Runs `terraform apply` in the Docker Container, will prompt user for Github OAuth Token
```
docker run -v `pwd`:/workspace -w /workspace -i -t hashicorp/terraform:light apply 
```

To add a member to the specified organization in `main.tf`, add the following code block to `organization.tf`:
```
module "add_name" {
  source = "./modules/organization_member"

  token = var.token

  username = "github_username"
  role = "member"
}
```

To create a new team in the organization, add the following code to `teams.tf`:
```
module "make_team_name" {
  source = "./modules/team"

  token = var.token

  name = "team_name"
  description = "team description"

  # Terraform list uses the same format/syntax as Python lists
  usernames = ["a list of all organization members to add to this team"]
}
```

To create a new repository in a specified team, add the following code to `team_repos.tf`:
```
module "make_team_name_repo_name" {
  source = "./modules/team_repo"

  token = var.token

  team_name = "desired_team_name"
  repo_name = "desired_repository_name"
}
```
