module "$module_name" {
    source = "./modules/team"

    token = var.token
    name = "$team_name"
    privacy = "$team_privacy"
    description = "$team_description"

    usernames = $member_usernames
}
