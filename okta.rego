package amp.okta

import future.keywords

user_permissions {
    user := input.users[_]
    login := user.login
    groups := user.groups
    permission := {
        "login": login,
        "accessRights": access_rights(groups, data.roles)
    }
}

access_rights(groups, roles) = [{ "resource": resource, "access": access }] {
    role := roles[groups[_]][_]
    resource := role[_]
    access := role[0]
}