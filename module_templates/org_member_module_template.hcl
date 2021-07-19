module "$module_name" {
    source = "./modules/organization_member"

    token = var.token

    username = "$username"
    role = "$role"
}
