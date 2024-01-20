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
                "access": access
            } |
            role := user.groups[_]
            resource := key
            access := access(resource, user, roles)
        ]
    }
}

access(resource, user, roles) = result {
    some role
    role = user.groups[_]
    some permission
    permission = roles[role][_][resource]
    result := permission
} else = "deny" {
    result := "deny"
}