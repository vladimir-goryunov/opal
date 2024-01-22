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
                "resource": resource[_],
                "role": role,
                "data.resource": data_resource
            } |
            role := groups[_]
            role_permissions := roles[role][_]
            access := key
            resource := role_permissions[access]

            data_resource := data.resources[_]
            #access := get_access(role_permissions, resource)

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