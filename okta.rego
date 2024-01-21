package amp.okta

import data.roles

user_permissions[permission] {
    user := input.users[_]
    login := user.login
    groups := user.groups
    permission := {
        "login": login,
        "accessRights": [
            {
                "access": access,
                "resource": resource[0]
            } |
            role := groups[_]
            role_permissions := roles[role][_]
            access := key
            resource := role_permissions[access]
        ]
    }
}