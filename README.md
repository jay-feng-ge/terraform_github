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
