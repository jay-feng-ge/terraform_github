import sys
from github import Github
from string import Template

g = Github("personal access key goes here")
org = g.get_organization("jay-feng-org")


def python_dict_to_hcl_map(dict):
    """Converts a Python dictionary to the string of an HCL dictionary."""
    dict_string = str(dict).replace("\'", "\"").replace(
        ":", " =").replace(",", "\n")
    dict_string = dict_string.replace("{", "{\n ").replace("}", "\n}")
    return dict_string


def python_list_to_hcl_list(list):
    """Converts a Python list to the string of an HCL list."""
    return str(list).replace("\'", "\"")


def python_bool_to_hcl_bool(bool):
    """Converts a Python boolean to the string of an HCL boolean."""
    return "true" if bool else "false"


def generate_repo_user_permissions(repo):
    """
    Takes in a PyGithub Repository object, returns a string of an HCL map representing the individual
    user permissions of a repository.
    """
    user_dict = {}
    for c in repo.get_collaborators():
        if repo.get_collaborator_permission(c) != "read":
            user_dict[c.login] = repo.get_collaborator_permission(c)

    return python_dict_to_hcl_map(user_dict)


def get_permission(permissions):
    """
    Helper function, takes in a PyGithub Permissions object, returns the Terraform permission value.
    Raises a ValueError if the permission object does not grant any permissions, or if the permission is only 'read'.
    """
    if permissions.triage:
        return "triage"
    elif permissions.push:
        return "push"
    elif permissions.pull:
        return "pull"
    elif permissions.maintain:
        return "maintain"
    elif permissions.admin:
        return "admin"
    else:
        raise ValueError('Team does not have any permissions.')


def generate_repo_team_permissions(repo):
    """
    Takes in a PyGithub Repository object, returns a string of an HCL map representing the team
    permissions of a repository.
    """
    team_dict = {}
    for t in repo.get_teams():
        team_dict[t.name] = get_permission(t.get_repo_permission(repo))

    return python_dict_to_hcl_map(team_dict)


def generate_branch_protections(repo):
    """
    Takes in a PyGithub Repository object, returns a string of an HCL list of maps representing the
    branch protection rules of the provided repository. If there are no branch protection rules,
    then an empty string is returned.
    """
    branches = [branch for branch in repo.get_branches()]
    all_bp_dict = []
    for branch in branches:
        try:
            bp = branch.get_protection()
        except:
            continue

        bp_dict = {}

        bp_dict["pattern"] = "*" + branch.name + "*"

        bp_dict["enforce_admins"] = python_bool_to_hcl_bool(bp.enforce_admins)

        bp_dict["required_status_checks"] = bp.required_status_checks
        if bp_dict["required_status_checks"] is not None:
            bp_dict["required_status_checks_strict"] = python_bool_to_hcl_bool(
                bp_dict["required_status_checks"].strict)
            bp_dict["required_status_checks_contexts"] = python_list_to_hcl_list(
                bp_dict["required_status_checks"].contexts).replace("\"", "*")
            bp_dict["required_status_checks"] = "true"
        else:
            bp_dict["required_status_checks_strict"] = "null"
            bp_dict["required_status_checks_contexts"] = "null"
            bp_dict["required_status_checks"] = "false"

        bp_dict["required_pr_reviews"] = bp.required_pull_request_reviews
        if bp_dict["required_pr_reviews"] is not None:
            bp_dict["required_pr_reviews_dismiss_stale_reviews"] = python_bool_to_hcl_bool(
                bp_dict["required_pr_reviews"].dismiss_stale_reviews)
            if bp_dict["required_pr_reviews"].dismissal_users is not None:
                bp_dict["required_pr_reviews_dismissal_restrictions"] = python_list_to_hcl_list(
                    [user.node_id for user in bp_dict["required_pr_reviews"].dismissal_users]).replace("\"", "*")
            else:
                bp_dict["required_pr_reviews_dismissal_restrictions"] = python_list_to_hcl_list([
                ])
            bp_dict["required_pr_reviews_require_code_owner_reviews"] = python_bool_to_hcl_bool(
                bp_dict["required_pr_reviews"].require_code_owner_reviews)
            bp_dict["required_pr_reviews_required_approving_review_count"] = bp_dict["required_pr_reviews"].required_approving_review_count
            bp_dict["required_pr_reviews"] = "true"
        else:
            bp_dict["required_pr_reviews_dismiss_stale_reviews"] = "null"
            bp_dict["required_pr_reviews_dismissal_restrictions"] = "null"
            bp_dict["required_pr_reviews_require_code_owner_reviews"] = "null"
            bp_dict["required_pr_reviews_required_approving_review_count"] = "null"
            bp_dict["required_pr_reviews"] = "false"

        if bp.get_user_push_restrictions() is not None:
            bp_dict["push_restrictions"] = python_list_to_hcl_list(
                [user.node_id for user in bp.get_user_push_restrictions()]).replace("\"", "*")
        else:
            bp_dict["push_restrictions"] = python_list_to_hcl_list([])

        bp_dict["require_signed_commits"] = "false"
        bp_dict["allows_deletions"] = "false"
        bp_dict["allows_force_pushes"] = "false"

        bp_dict["id"] = hash(frozenset(bp_dict.items()))

        all_bp_dict.append(bp_dict)

    if len(all_bp_dict) == 0:
        return ""
    else:
        all_bp_dict_string = "[\n" + ",\n".join([python_dict_to_hcl_map(bp_dict) for
                                                 bp_dict in all_bp_dict]) + "\n]"

        all_bp_dict_string = all_bp_dict_string.replace(
            "\"", "").replace("*", "\"")

        return "branch_protections = " + all_bp_dict_string


def generate_deploy_keys(repo):
    """
    Takes in a PyGithub Repository object, returns a string of an HCL list of maps, where each map represents
    and contains the arguments for a deploy key for the given repository.
    """
    deploy_keys = [key for key in repo.get_keys()]
    deploy_keys_args = []
    for key in deploy_keys:
        deploy_key_dict = {}
        deploy_key_dict["id"] = key.id
        deploy_key_dict["title"] = key.title
        deploy_key_dict["key"] = key.key
        deploy_key_dict["read_only"] = python_bool_to_hcl_bool(key.read_only)
        deploy_keys_args.append(deploy_key_dict)

    deploy_keys_string = "[\n" + ",\n".join([python_dict_to_hcl_map(key_dict) for
                                             key_dict in deploy_keys_args]) + "\n]"

    deploy_keys_string = deploy_keys_string.replace("\"id\"", "id")
    deploy_keys_string = deploy_keys_string.replace("\"title\"", "title")
    deploy_keys_string = deploy_keys_string.replace("\"key\"", "key")
    deploy_keys_string = deploy_keys_string.replace(
        "\"read_only\"", "read_only")

    return deploy_keys_string


def generate_repo_config(repo_name):
    """
    Takes in a repository name, returns an string of the HCL repository module configuration.
    """
    repo = org.get_repo(repo_name)

    module_name = "make_" + repo_name
    description = "null" if (repo.description is None) else repo.description
    visibility = "private" if repo.private else "public"
    allow_merge_commit = python_bool_to_hcl_bool(repo.allow_merge_commit)

    users = generate_repo_user_permissions(repo)
    teams = generate_repo_team_permissions(repo)

    branch_protections = generate_branch_protections(repo)

    deploy_keys = generate_deploy_keys(repo)

    # store the template string in a file and read it in
    module_template = open(
        "./module_templates/repo_module_template.hcl").read()
    t = Template(module_template)
    return t.substitute(module_name=module_name,
                        repo_name=repo_name,
                        description=description,
                        visibility=visibility,
                        allow_merge_commit=allow_merge_commit,
                        users=users,
                        teams=teams,
                        branch_protections=branch_protections,
                        deploy_keys=deploy_keys)


def main():
    """
    Writes the repository module configuration into the `import_repos.tf` file.
    Prints out the terraform import statements needed to be run after `terraform init`.
    """
    repo_name = sys.argv[1]

    result = generate_repo_config(repo_name) + "\n\n"

    f = open("./import_repos.tf", "a")
    f.write(result)
    f.close()

    repo = org.get_repo(repo_name)

    print("Run following commands after running `terraform init`:")
    print("terraform import module.make_" +
          repo.name +
          ".github_repository.some_repo " +
          repo.name)

    for branch in repo.get_branches():
        try:
            branch_protection = branch.get_protection()
        except:
            continue
        else:
            print("terraform import module.make_" +
                  repo.name +
                  ".github_branch_protection.some_repo_branch_protection " +
                  repo.name +
                  ":" +
                  branch.name)


if __name__ == '__main__':
    main()
