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
    repo_name = "$repo_name"
    branch_protection_pattern = "$bp_pattern"
    branch_protection_enforce_admins = $bp_enforce_admins
    branch_protection_required_status_checks_strict = $bp_required_status_checks_strict
    branch_protection_required_status_checks_contexts = $bp_required_status_checks_contexts
    branch_protection_required_pr_reviews_dismiss_stale_reviews = $bp_required_pr_reviews_dismiss_stale_reviews
    branch_protection_required_pr_reviews_dismissal_restrictions = $bp_required_pr_reviews_dismissal_restrictions
    branch_protection_required_pr_reviews_require_code_owner_reviews = $bp_required_pr_reviews_require_code_owner_reviews
    branch_protection_required_pr_reviews_required_approving_review_count = $bp_required_pr_reviews_required_approving_review_count
    branch_protection_push_restrictions = $bp_push_restrictions

    # deploy key variables
    deploy_keys = $deploy_keys
}
