# IMPORTANT: this repo must be public or you must have Github Pro
# for some of this functionality (ex. required code reviewers)
# see: https://github.com/pricing


variable "branch_protections" {
  type = list
  default = [
    {
      pattern                                             = "main"
      enforce_admins                                      = true
      required_status_checks                              = false
      required_status_checks_strict                       = null
      required_status_checks_contexts                     = null
      required_pr_reviews                                 = true
      required_pr_reviews_dismiss_stale_reviews           = false
      required_pr_reviews_dismissal_restrictions          = []
      required_pr_reviews_require_code_owner_reviews      = false
      required_pr_reviews_required_approving_review_count = 1
      push_restrictions                                   = []
      require_signed_commits                              = false
      allows_deletions                                    = false
      allows_force_pushes                                 = false
      id                                                  = 1
    },
  ]
}

resource "github_branch_protection" "some_repo_branch_protection" {
  #required
  repository_id = github_repository.some_repo.name

  for_each = {for branch_protection in var.branch_protections:  branch_protection.id => branch_protection}

  pattern          = each.value.pattern
  enforce_admins   = each.value.enforce_admins
  require_signed_commits = each.value.require_signed_commits

  required_status_checks {
    strict = each.value.required_status_checks_strict
    contexts = each.value.required_status_checks_contexts
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = each.value.required_pr_reviews_dismiss_stale_reviews
    dismissal_restrictions = each.value.required_pr_reviews_dismissal_restrictions
    require_code_owner_reviews = each.value.required_pr_reviews_require_code_owner_reviews
    required_approving_review_count = each.value.required_pr_reviews_required_approving_review_count
  }

  push_restrictions = each.value.push_restrictions
  allows_deletions = each.value.allows_deletions
  allows_force_pushes = each.value.allows_force_pushes
}
