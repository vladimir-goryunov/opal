package amp.okta

import future.keywords

policies contains policy if {
    user := input.users[_]
    policy := {
        "login": user.login,
        "accessResource": accessResource(user, data.policies.roles)
    }
}

accessResource(user, roles) = result {
    some role
    role in user.groups
    some access
    access := roles[role][_]
    result := [{"access": a, "resource": r} |
        r := data.policies.resources[_]
        a := access[r]
    ]
}