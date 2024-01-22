package amp.okta

import data.roles

user_permissions[permission] {
    user := input.users[_]
    login := user.login
    groups := user.groups
    permission := generatePermissionsForUser(login, groups)
}

generatePermissionsForUser(login, groups) = permissions {
    permissions := {
        "login": login,
        "permissions": generatePermissionsForGroups(groups)
    }
}

generatePermissionsForGroups(groups) = merge([generateAccessForGroups(groups[_]) | true])

generateAccessForGroups(group) = accessList {
    accessList := [access | role := group; access := generateAccess(role, roles)]
}

generateAccess(role, roles) = access {
    role_permissions := roles[role][_]
    access := {
        "access": key,
        "resource": role_permissions[key],
        "role": role
    }
}