package amp.okta

import data.roles

user_permissions[permission] {
    user := input.users[_]
    login := user.login
    permission := {
        "login": login,
        "accessRights": [
            {
                "the_access": resource,
                "the_resource": access_decision(resource, user, roles)
            } |
            role := user.groups[_]
            resource := resource
        ]
    }
}

access_decision(resource, user, roles) = decision {
    role := user.groups[_]
    permission := roles[role][_][resource]
    decision := get_access_decision(permission)
}

get_access_decision(permission) = "view" {
    permission != null
}

get_access_decision(permission) = "edit" {
    permission == "the_edit"
}

get_access_decision(permission) = "deny" {
    not permission
}