package amp.okta

import data.roles
import data.resources

user_permissions = {
    "result": {
        "user_permissions": [
            {
                "accessRights": [access_rights(resource, role) |
                    resource := data.resources[_]
                    role := input.users[_].groups[_]
                    contains(data.roles[role][_], resource)
                ],
                "login": input.users[_].login
            }
        ]
    }
}

access_rights(resource, role) = {
    "resource": resource,
    "access": "view"
} {
    contains(data.roles[role][_].view, resource)
}

access_rights(resource, role) = {
    "resource": resource,
    "access": "edit"
} {
    contains(data.roles[role][_].edit, resource)
}

access_rights(resource, role) = {
    "resource": resource,
    "access": "deny"
} {
    not contains(data.roles[role][_].view, resource)
    not contains(data.roles[role][_].edit, resource)
}