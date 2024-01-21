package amp.okta

import data.policies.roles

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
            resource := data.policies.resources[_]
            access := get_access(role_permissions, resource)
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