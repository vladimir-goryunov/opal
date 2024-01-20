package amp.okta
import data.roles

user_permissions[permission] {
    user := input.users[_]
    login := user.login
    groups := user.groups
    permission := {
        "login": login,
        "accessRights": [access_right(resource, groups, roles) | resource := data.resources]
    }
}

access_right(resource, groups, roles) = access {
    access := get_access(groups, resource, roles)
}

get_access(groups, resource, roles) = result {
    role = groups[_]
    role_permissions := roles[role][_]
    resource_access := role_permissions[resource]
    result := resource_access
} else = "deny"