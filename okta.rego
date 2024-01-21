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
                "resource": resource
            } |
            role := groups[_]
            role_permissions := roles[role][_]
            resource := data.resources[_]
            access := get_access(role_permissions, resource)
            debug(sprintf("User %s has %s access to resource %s", [login, access, resource]))
        ]
    }
}

get_access(role_permissions, resource) = result {
    access := role_permissions[resource]
    result := input_access(access)
}

input_access(access) = result {
    result := input_access_map[access]
}

input_access_map = {
    "view": "view",
    "edit": "edit",
    "deny": "deny"
}