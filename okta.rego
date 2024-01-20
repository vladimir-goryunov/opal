package amp.okta


import data.roles

user_permissions[permission] {
    user := input.users[_]
    login := user.login
    permission := {
        "login": login,
        "accessRights": [
            {
                "resource": resource,
                "access": access(resource, user, roles)
            } |
            role := user.groups[_]
            resource := key
        ]
    }
}

access(resource, user, roles) {
    role = user.groups[_]
    permission = roles[role][_][resource]
    permission != null
}

access(resource, user, roles) = "view" {
    access(resource, user, roles)
}

access(resource, user, roles) = "edit" {
    access := access(resource, user, roles)
    access == "edit"
}

access(resource, user, roles) = "deny" {
    not access(resource, user, roles)
}