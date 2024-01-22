package amp.okta

import data.policies

policies_contains_policy {
    user := input.users[_]
    policy := {
        "login": user.login,
        "accessResource": accessResource(user, data.policies.roles)
    }
}

accessResource(user, roles) = result {
    result := []
    some role
    role := user.groups[_]
    some access, resource
    access := roles[role][resource]
    result := [{"access": access, "resource": resource} | resource := roles[role][access]]
} else = [{"access": "deny", "resource": resource}]