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
                "1.access": access,
                "2.resource": resource[_],
                "3.role": role,
                "4.data_resource": data_resource,
                "5.access_resource": access_resource
            } |
            role := groups[_]
            role_permissions := roles[role][_]
            access := key
            resource := role_permissions[access]

            data_resource := data.resources[_]
            access_resource := get_access(resource, groups, roles)
        ]
    }
}

get_access(resourceName, groups, roles) = result {
    some role
    role = groups[_]
    resourceName in roles[role][_]["edit"]
    result := "edit"
} else = "view" {
    some role
    role = groups[_]
    resourceName in roles[role][_]["view"]
} else = "deny" {
    result := "deny"
}