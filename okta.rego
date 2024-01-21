package amp.okta

import data.roles

user_permissions[permission] {
    user := input.users[_]
    login := user.login
    groups := user.groups
    permission := {
        "login": login,
        "permissions": [
            {
                "access": access,
                "resource": resource[_]
            } |
            role := groups[_]
            role_permissions := roles[role][_]
            access := key
            resource := role_permissions[access]
            printf("User %s has %s access to resource %s", [login, access, resource])
        ]
    }
}