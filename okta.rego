package amp.okta

import data.roles

user_permissions[permission] {
    user := input.users[_]
    login := user.login
    permission := {
        "login": login,
        "accessRights": access_decisions(user, roles)
    }
}

access_decisions(user, roles) = decisions {
    decisions := [access_decision(resource, user, roles) |
        role := user.groups[_]
        resource := resource
    ]
}

access_decision(resource, user, roles) = decision {
    role := user.groups[_]
    permission := roles[role][_][resource]
    decision := get_access_decision(permission, resource)
}

get_access_decision(permission, resource) = {"resource": resource, "access": "view"} {
    permission != null
}

get_access_decision(permission, resource) = {"resource": resource, "access": "edit"} {
    permission == "edit"
}

get_access_decision(permission, resource) = {"resource": resource, "access": "deny"} {
    not permission
}