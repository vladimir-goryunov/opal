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
                "resource": resource,
                "access": access[0]
            } |
            role := groups[_]
            role_permissions := roles[role][_]
            resource := key
            access := role_permissions[resource]
        ]
    }
}