# IMPORTANT: this repo must be public or you must have Github Pro
# for some of this functionality (ex. required code reviewers)
# see: https://github.com/pricing

variable "branch_protection_pattern" {
  type = string
  default = null
}

variable "branch_protection_enforce_admins" {
  type = bool
  default = false
}

variable "branch_protection_require_signed_commits" {
  type = bool
  default = false
}

variable "branch_protection_required_status_checks_strict" {
  type = bool
  default = null
}

variable "branch_protection_required_status_checks_contexts" {
  type = list
  default = null
}

variable "branch_protection_required_pr_reviews_dismiss_stale_reviews" {
  type = bool
  default = null
}

variable "branch_protection_required_pr_reviews_dismissal_restrictions" {
  type = list
  default = null
}

variable "branch_protection_required_pr_reviews_require_code_owner_reviews" {
  type = bool
  default = null
}

variable "branch_protection_required_pr_reviews_required_approving_review_count" {
  type = number
  default = null
}

variable "branch_protection_push_restrictions" {
  type = list
  default = []
}

variable "branch_protection_allows_deletions" {
  type = bool
  default = false
}

variable "branch_protection_allows_force_pushes" {
  type = bool
  default = false
}

resource "github_branch_protection" "some_repo_branch_protection" {
  # required
  repository_id = var.repo_name
  # required
  pattern          = var.branch_protection_pattern

  # optional, default false
  enforce_admins   = var.branch_protection_enforce_admins

  # optional, default false
  require_signed_commits = var.branch_protection_require_signed_commits

  # optional, strict defaults to false and contexts defaults to empty list
  required_status_checks {
    strict = var.branch_protection_required_status_checks_strict
    contexts = var.branch_protection_required_status_checks_contexts
  }

  # optional, defaults values are false, empty list, false, no default
  required_pull_request_reviews {
    dismiss_stale_reviews = var.branch_protection_required_pr_reviews_dismiss_stale_reviews
    dismissal_restrictions = var.branch_protection_required_pr_reviews_dismissal_restrictions
    require_code_owner_reviews = var.branch_protection_required_pr_reviews_require_code_owner_reviews
    required_approving_review_count = var.branch_protection_required_pr_reviews_required_approving_review_count
  }

  # optional, defaults to empty list
  push_restrictions = var.branch_protection_push_restrictions

  # optional, defaults to false
  allows_deletions = var.branch_protection_allows_deletions

  # optional, defaults to false
  allows_force_pushes = var.branch_protection_allows_force_pushes
}
