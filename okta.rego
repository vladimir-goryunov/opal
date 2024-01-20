package amp.okta

import data.roles
import data.resources

user_permissions = {
    "result": {
        "user_permissions": [
            {
                "accessRights": [access_rights(resource, role) |
                    resource := data.resources[i]
                    role := input.users[j].groups[k]
                    contains(data.roles[role][l], resource)
                ],
                "login": input.users[m].login
            }
        ]
    }
}

access_rights(resource, role) = {
    "resource": resource,
    "access": "view"
} {
    contains(data.roles[role][n].view, resource)
}

access_rights(resource, role) = {
    "resource": resource,
    "access": "edit"
} {
    contains(data.roles[role][o].edit, resource)
}

access_rights(resource, role) = {
    "resource": resource,
    "access": "none"
} {
    not contains(data.roles[role][p].view, resource)
    not contains(data.roles[role][q].edit, resource)
}