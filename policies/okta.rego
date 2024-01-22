package amp.okta

policies_contains_policy {
    some user
    user := input.users[_]
    policy := {
        "login": user.login,
        "accessResource": accessResource(user, data.policies.roles)
    }
}

accessResource(user, roles) = result {
    role_access := roles[user.login]
    result := [{"access": access, "resource": resource} |
        resource := role_access[_]
        access := role_access[resource]
    ]
}