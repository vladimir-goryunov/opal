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
    accessList := [generateAccess(role, roles) | role := groups[_]]
}

generateAccess(role, roles) = access {
    role_permissions := roles[role][_]
    access := {
        "access": key,
        "resource": role_permissions[key],
        "role": role
    }
}