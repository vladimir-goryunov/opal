package amp.okta

import data.roles
import data.resources

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
        resource := data.resources[_]
        decision := get_access_decision(user, roles, resource)
        decision.access != "deny"
    ]
}

access_decision(resource, user, roles) = {"access": decision, "resource": resource} {
    role := user.groups[_]
    permission := roles[role][_][resource]
    decision := get_access_decision(user, roles, resource)
}

get_access_decision(user, roles, resource) = decision {
    role := user.groups[_]
    permission := roles[role][_][resource]
    decision := get_decision(permission)
}

get_decision(permission) = {"access": "view"} {
    permission == "view"
}

get_decision(permission) = {"access": "edit"} {
    permission == "edit"
}

get_decision(permission) = {"access": "deny"} {
    not permission
}