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
    accessList := generateAccessForGroups(groups)
}

generateAccessForGroups(groups) = [access | role := groups[_]; access := generateAccess(role, roles)]

generateAccess(role, roles) = {
    "access": key,
    "resource": resource,
    "role": role
} {
    role_permissions := roles[role][_]
    access := role_permissions[key]
    resource := key
}