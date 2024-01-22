package amp.okta

import data.roles

user_permissions[permission] {
    user := input.users[_]
    login := user.login
    groups := user.groups
    permissions := generatePermissionsForUser(login, groups)
    permission := {
        "login": login,
        "permissions": permissions
    }
}

generatePermissionsForUser(login, groups) = permissions {
    permissions := generatePermissionsForGroups(groups)
}

generatePermissionsForGroups(groups) = [access | group := groups[_]; role := group; access := generateAccess(role, roles)]

generateAccess(role, roles) = access {
    role_permissions := roles[role][_]
    access := {
        "access": key,
        "resource": role_permissions[key],
        "role": role
    }
}