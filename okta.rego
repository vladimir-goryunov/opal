package amp.okta

import data.roles

user_permissions[permission] {
    user := input.users[_]
    login := user.login
    user_groups := user.groups[_]
    permission := generatePermissions(login, user_groups)
}

generatePermissions(login, user_groups) = permissions {
    permissions := {
        "login": login,
        "permissions": generateAccessList(user_groups)
    }
}

generateAccessList(user_groups) = result {
    some role
    role in user_groups
    result := role[_]
}


#generatePermissions(login, groups) = permissions {
#    permissions := {
#        "login": login,
#        "permissions": generateAccessList(groups)
#    }
#}
#
#generateAccessList(groups) = accessList {
#    accessList := [generateAccess(role, groups, roles) | role := groups[0]]
#}
#
#generateAccess(role, groups, roles) = {
#    "access": access,
#    "resource": resource
#    "role": role
#} {
#    role_permissions := roles[role][_]
#    access := key
#    resource := role_permissions[access]
#}