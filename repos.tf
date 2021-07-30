# TEMPLATE

# module "make_repo-name" {
#   source = "./modules/repo"
#
#   token = var.token
#
#   repo_name          = "repo-name"
#   description        = "to be imported"
#   visibility         = "public"
#   allow_merge_commit = "true"
#
#   # access permission variables
#   users = {
#     "username" = "admin/pull/push/maintain/triage"
#     ...
#   }
#   teams = {
#     "team_name" = "admin/pull/push/maintain/triage"
#     ...
#   }
#
#   # branch protection variables
#   branch_protections = [
#     {
#       pattern                                             = "main"
#       enforce_admins                                      = false
#       required_status_checks                              = false
#       required_status_checks_strict                       = null
#       required_status_checks_contexts                     = null
#       required_pr_reviews                                 = true
#       required_pr_reviews_dismiss_stale_reviews           = false
#       required_pr_reviews_dismissal_restrictions          = []
#       required_pr_reviews_require_code_owner_reviews      = false
#       required_pr_reviews_required_approving_review_count = 1
#       push_restrictions                                   = []
#       require_signed_commits                              = false
#       allows_deletions                                    = false
#       allows_force_pushes                                 = false
#       id                                                  = 12345
#     }
#     ...
#   ]
#
#   # deploy key variables
#   deploy_keys = [
#     {
#       title = "deploy_key_title"
#       key = "deploy_key_value"
#       read_only = false
#     }
#     ...
#   ]
# }
