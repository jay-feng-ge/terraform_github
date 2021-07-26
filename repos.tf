module "make_test_repo_3" {
  source = "./modules/repo"

  token = var.token

  repo_name   = "test_repo_3"
  description = "testing edited terraform repo module"
  visibility = "public"

  teams = {
    "team_1"        = "push"
    "team_2_manual" = "pull"
  }

  users = {
    "vinayakgajjewar" = "pull"
  }

  deploy_keys = [
    {
      "title" = "test_deploy_key"
      "key" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDza2ziuWAQD68cyGM2Ycdq8dPsKBKCDr1vb+I6utDgKV6DYDJyuwhJVlrJoG13f4IJll+eYCMLLwiKHL0fjEqz/8EK1UrfQSDU9T8tA5hLo4iQwIqMNgnWE/v9Yx2hWZwsEebBZ+ZMpxdDvxu3QbQ9Ey14IzH0pY9UWczZKAvYeIliNnXlbkOfTqrzF1NSNTeOQTHjKQs/JA8hYXMxs2W/hPKnhgppJBDRRVWYMjTq57qLnxXP3OpjQC6Vs0HMzXk1eDcVO3kqHC1DnslWGWazcabiyKWrVRrIZ5r1iHvF7Y/yLlflvJuum5c8slvFiulhFYAOypMzv1MGpFO8Ib7koU4GSMTEARU4+jdsA07kXPtJnxEWhKP5ITZ73Dd2dvZsf/zvlR9E6Fo8wV/CDqjcr8TfAmG58VfrQByslOHxlZnA3yrJ8C6wSKncq8YhLpOabR2EE2j5nHqMfYp1NkQm6ipiGChyGn/jvL2RVqOpgAd9B5pxIhvJVJD9HNra03M="
      "read_only" = true
      "id" = "this_value_doesnt_matter"
    }
  ]

}
