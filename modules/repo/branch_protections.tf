# IMPORTANT: this repo must be public or you must have Github Pro
# for some of this functionality (ex. required code reviewers)
# see: https://github.com/pricing

variable "branch_protections" {
  type = list
  default = []
}

resource "github_branch_protection" "some_repo_branch_protection" {
  #required
  repository_id = github_repository.some_repo.name

  for_each = {for branch_protection in var.branch_protections:  branch_protection.id => branch_protection}

  # required
  pattern          = each.value.pattern

  # optional, default false
  enforce_admins   = each.value.enforce_admins

  # optional, default false
  require_signed_commits = each.value.require_signed_commits

  # optional, strict defaults to false and contexts defaults to empty list
  required_status_checks {
    strict = each.value.required_status_checks_strict
    contexts = each.value.required_status_checks_contexts
  }

  # optional, defaults values are false, empty list, false, no default
  required_pull_request_reviews {
    dismiss_stale_reviews = each.value.required_pr_reviews_dismiss_stale_reviews
    dismissal_restrictions = each.value.required_pr_reviews_dismissal_restrictions
    require_code_owner_reviews = each.value.required_pr_reviews_require_code_owner_reviews
    required_approving_review_count = each.value.required_pr_reviews_required_approving_review_count
  }

  # optional, defaults to empty list
  push_restrictions = each.value.push_restrictions

  # optional, defaults to false
  allows_deletions = each.value.allows_deletions

  # optional, defaults to false
  allows_force_pushes = each.value.allows_force_pushes
}
