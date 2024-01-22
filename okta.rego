package amp.okta

import data.roles

user_permissions[permission] {
    user := input.users[_]
    login := user.login
    groups := user.groups
    permission := generatePermissions(login, groups)
}

generatePermissions(login, groups) = permissions {
    permissions := {
        "login": login,
        "permissions": generateAccessList(groups)
    }
}

generateAccessList(groups) = accessList {
    accessList := [generateAccess(role, groups, roles) | role := groups[_]]
}

generateAccess(role, groups, roles) = {
    "access_to_resource": access,
    "resource_name": resource,
    "role_name": role
} {
    role_permissions := roles[role][_]
    access := key
    resource := role_permissions[access]
}