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
                "data_resource": data_resource,
                "access_to_resource": access_to_resource
            } |
            role := groups[_]
            role_permissions := roles[role][_]
            access := key
            resource := role_permissions[access]

            data_resource := data.resources[_]
            access_to_resource := get_access(role_permissions, resource)
        ]
    }
}

get_access(role_permissions, resource) = result {
    access_to_resource := role_permissions[resource]
    result := input_access(access_to_resource)
}

#input_access(access_to_resource) = result {
#    result := input_access_map[access_to_resource]
#}

input_access(access_to_resource) = result {
    access_to_resource in input_access_map["edit"]
    result := "edit"
} else = "view" {
    access_to_resource in input_access_map["view"]
    result := "view"
} else = "deny"

input_access_map = {
    "view": "view",
    "edit": "edit",
    "deny": "deny"
}