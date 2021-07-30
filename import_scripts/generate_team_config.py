import sys
from github import Github
from string import Template

g = Github("personal access key goes here")
org = g.get_organization("jay-feng-org")


def generate_team_config(team_name):
    """
    Takes in a repository name, returns an string of the HCL Github team module configuration.
    """
    try:
        for team in org.get_teams():
            if team.name == team_name:
                team_id = team.id
    except:
        raise ValueError('Team not found')

    team = org.get_team(team_id)
    team_description = team.description
    team_privacy = team.privacy

    module_name = "make_" + team_name
    member_usernames = str(
        [member.login for member in team.get_members()]).replace("\'", "\"")

    module_template = open(
        "./module_templates/team_module_template.hcl").read()
    t = Template(module_template)
    return t.substitute(module_name=module_name,
                        team_name=team.name,
                        team_description=team_description,
                        team_privacy=team_privacy,
                        member_usernames=member_usernames)


def main():
    """
    Writes the team module configuration into the `import_teams.tf` file.
    Prints out the terraform import statements needed to be run after `terraform init`.
    """
    team_name = sys.argv[1]

    result = generate_team_config(team_name) + "\n\n"

    f = open("./import_teams.tf", "a")
    f.write(result)
    f.close()

    print("Run following commands after running `terraform init`:")
    print("terraform import module.make_" +
          team_name +
          ".github_team.some_team " +
          str(org.get_team_by_slug(team_name).id))


if __name__ == '__main__':
    main()
