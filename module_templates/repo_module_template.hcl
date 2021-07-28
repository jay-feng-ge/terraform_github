module "$module_name" {
    source = "./modules/repo"

    token = var.token

    repo_name   = "$repo_name"
    description = "$description"
    visibility = "$visibility"
    allow_merge_commit = "$allow_merge_commit"

    # access permission variables
    users = $users
    teams = $teams

    # branch protection variables
    branch_protections = $branch_protections

    # deploy key variables
    deploy_keys = $deploy_keys
}
