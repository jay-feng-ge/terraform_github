module "$module_name" {
    source = "./modules/repo"

    token = var.token
    
    repo_name   = "$repo_name"
    description = "$description"
    visibility = "$visibility"
    allow_merge_commit = "$allow_merge_commit"

    users = $users
    teams = $teams
}
