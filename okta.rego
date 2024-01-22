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

generatePermissionsForGroups(groups) = access {
    access := [generateAccessForGroup(group_permissions, roles) | group_permissions := map[group | group := groups][_]]
}

generateAccessForGroup(group_permissions, roles) = [access | role := group_permissions; access := {
    "access": key,
    "resource": role_permissions[key],
    "role": role
}]