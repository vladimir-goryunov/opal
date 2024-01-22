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

generateAccessForGroups(groups) = accessList {
    accessList := [access | role := groups[_]; access := generateAccess(role, roles)]
}

generateAccess(role, roles) = access {
    role_permissions := roles[role][_]
    access := {
        "access": key,
        "resource": role_permissions[key],
        "role": role
    }
}