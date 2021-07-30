# terraform_github
Using Terraform, an infrastructure-as-code tool, to manage, encapsulate, and audit a Github organization.

## Current functionality:
  - Github Organization Membership
    - either member or maintainer
  - Github Teams
    - manage team members
    - manage team visibilty
  - Github Repositories
    - manage permission levels for teams and users
    - manage repo visibility
    - manage various action permissions
    - manage branch protection rules
    - manage deploy keys

## How to Import Existing Terraform Resources:
  - Import Existing Github Organization Membership
    - from the root project directory, run `python import_scripts/generate_membership_config.py github_username`, for the desired Github user
      - this will add the HCL module configuration code to `import_org_members.tf`
      - the script will print a `terraform import ...` command into the console 
    - run `terraform init` so that the imported resources are being tracked by the Terraform state
    - run the `terraform import ...` command from above
    - run `terraform apply` to finish importing the existing organization membership
  - Import Existing Github Team
    - from the root project directory, run `python import_scripts/generate_team_config.py github_username`, for the desired Github team
      - this will add the HCL module configuration code to `import_teams.tf`
      - the script will print a `terraform import ...` command into the console
    - run `terraform init` so that the imported resources are being tracked by the Terraform state
    - run the `terraform import ...` command from above
    - run `terraform apply` to finish importing the existing team
  - Import Existing Github Repository
    - from the root project directory, run `python import_scripts/generate_repo_config.py github_username`, for the desired Github repository
      - this will add the HCL module configuration code to `import_repo.tf`
      - the script will print multiple `terraform import ...` commands into the console
    - run `terraform init` so that the imported resources are being tracked by the Terraform state
    - run the `terraform import ...` commands from above
    - run `terraform apply` to finish importing the existing repository
