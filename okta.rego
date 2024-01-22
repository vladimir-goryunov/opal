package amp.okta

import data.roles

user_permissions[permission] {
    #user := input.users[_]
    user := input.users[0]
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
    accessList := [generateAccess(role, groups, roles) | role := groups[0]]
}

generateAccess(role, groups, roles) = {
    "access": access,
    "resource": resource
    #"role": role
} {
    role_permissions := roles[role][_]
    access := key
    resource := role_permissions[access]
}