package amp.okta

import data.policies

policies_contains_policy {
    some user
    user := input.users[_]
    policy := {
        "login": user.login,
        "accessResource": accessResource(user, data.policies.roles)
    }
}

accessResource(user, roles) = result {
    result := []
    role_access := {role: access |
        role := user.groups[_]
        access := roles[role][_]
    }
    result = [{"access": access, "resource": resource} |
        role := role_access[_]
        resource := roles[role][_]
        access := role_access[role]
    ]
}