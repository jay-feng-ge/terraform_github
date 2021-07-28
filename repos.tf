
module "make_test_repo_3" {
  source = "./modules/repo"

  token = var.token

  repo_name          = "test_repo_3"
  description        = "testing edited terraform repo module"
  visibility         = "public"
  allow_merge_commit = "true"

  # access permission variables
  users = {
    "jay-feng-ge" = "admin"
    "vinayakgajjewar" = "pull"
  }
  teams = {
    "team_1" = "pull"
    "team_2_manual" = "pull"
  }

  # branch protection variables
  branch_protections = [
    {
      pattern                                             = "another_branch"
      enforce_admins                                      = false
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
      id                                                  = -4944656874416880449
    },
    {
      pattern                                             = "master"
      enforce_admins                                      = true
      required_status_checks                              = false
      required_status_checks_strict                       = null
      required_status_checks_contexts                     = null
      required_pr_reviews                                 = true
      required_pr_reviews_dismiss_stale_reviews           = true
      required_pr_reviews_dismissal_restrictions          = ["jay-feng-ge"]
      required_pr_reviews_require_code_owner_reviews      = true
      required_pr_reviews_required_approving_review_count = 1
      push_restrictions                                   = ["jay-feng-ge"]
      require_signed_commits                              = false
      allows_deletions                                    = false
      allows_force_pushes                                 = false
      id                                                  = 7430462046465894618
    }
  ]

  # deploy key variables
  deploy_keys = [
    {
      "title"     = "test_deploy_key_2"
      "key"       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDza2ziuWAQD68cyGM2Ycdq8dPsKBKCDr1vb+I6utDgKV6DYDJyuwhJVlrJoG13f4IJll+eYCMLLwiKHL0fjEqz/8EK1UrfQSDU9T8tA5hLo4iQwIqMNgnWE/v9Yx2hWZwsEebBZ+ZMpxdDvxu3QbQ9Ey14IzH0pY9UWczZKAvYeIliNnXlbkOfTqrzF1NSNTeOQTHjKQs/JA8hYXMxs2W/hPKnhgppJBDRRVWYMjTq57qLnxXP3OpjQC6Vs0HMzXk1eDcVO3kqHC1DnslWGWazcabiyKWrVRrIZ5r1iHvF7Y/yLlflvJuum5c8slvFiulhFYAOypMzv1MGpFO8Ib7koU4GSMTEARU4+jdsA07kXPtJnxEWhKP5ITZ73Dd2dvZsf/zvlR9E6Fo8wV/CDqjcr8TfAmG58VfrQByslOHxlZnA3yrJ8C6wSKncq8YhLpOabR2EE2j5nHqMfYp1NkQm6ipiGChyGn/jvL2RVqOpgAd9B5pxIhvJVJD9HNra03M="
      "read_only" = true
      "id"        = "this_value_doesnt_matter"
    }
  ]
}
