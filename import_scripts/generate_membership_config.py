import sys
from github import Github
from string import Template

g = Github("personal access key goes here")
org = g.get_organization("jay-feng-org")


def generate_org_member_config(username):
    """
    Takes in a Github username, returns an string of the HCL Github organization membership module configuration.
    """
    module_name = "add_" + username
    member = [member for member in org.get_members() if member.login ==
              username][0]
    role = member.get_organization_membership(org).role

    module_template = open(
        "./module_templates/org_member_module_template.hcl").read()
    t = Template(module_template)
    return t.substitute(module_name=module_name,
                        username=username,
                        role=role)


def main():
    """
    Writes the organization member module configuration into the `import_org_members.tf` file.
    Prints out the terraform import statements needed to be run after `terraform init`.
    """
    username = sys.argv[1]

    result = generate_org_member_config(username) + "\n\n"

    f = open("./import_org_members.tf", "a")
    f.write(result)
    f.close()

    print("Run following commands after running `terraform init`:")
    print("terraform import module.add_" +
          username +
          ".github_membership.membership_for_some_user jay-feng-org:" +
          username)


if __name__ == '__main__':
    main()
