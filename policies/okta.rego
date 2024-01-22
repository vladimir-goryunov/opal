package amp.okta

policies contains policy if {
    user := input.users[_]
    policy := {
        "login": user.login,
        "accessResource": accessResource(user, data.policies.roles)
    }
}

accessResource(user, roles) = result {
    role := user.login
    role_access := roles[role]
    result := [{"access": access, "resource": resource} |
        resource := role_access[_]
        access := role_access[resource]
    ]
}