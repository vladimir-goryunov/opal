package amp.okta

policies contains policy if {
    user := input.users[_]
    policy := {
        "login": user.login,
        "accessResource": accessResource(user, data.policies.roles)
    }
}

accessResource(user, roles) = result {
    some role
    role = user.login
    result := [{"access": access, "resource": resource} |
        role_access := roles[role]
        resource := role_access[_]
        access := role_access[resource]
    ]
}