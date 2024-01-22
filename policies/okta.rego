package amp.okta

import future.keywords

policies contains policy if {
    user := input.users[_]

    some resourceName in data.policies.resources

    policy := {
        "login": user.login,
        "accessResource": accessResource(resourceName, user, data.policies.roles)
    }
}

accessResource(resourceName, user, roles) = result {
    some role
    role in user.groups
    resourceName in roles[role][_]["edit"]
    result := [{"access": "edit", "resource": resourceName}]
} else = [{"access": "view", "resource": resourceName}] {
    some role
    role in user.groups
    resourceName in roles[role][_]["view"]
} else = [{"access": "deny", "resource": resourceName}]