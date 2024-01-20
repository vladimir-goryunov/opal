package amp.okta

import data.roles
import data.resources

user_permissions = {
    "result": {
        "user_permissions": [
            {
                "login": input.users[i].login,
                "accessRights": access_rights_for_user(input.users[i])
            }
            |
            i < count(input.users)
        ]
    }
}

access_rights_for_user(user) = access_rights_for_groups(user.groups)

access_rights_for_groups(groups) = [access_rights_for_resource(group, resource) |
    group := groups[k]
    resource := data.resources[j]
    j < count(data.resources)
    k < count(groups)
]

access_rights_for_resource(role, resource) = {
    "resource": resource,
    "access": "view"
} {
    contains(data.roles[role].view, resource)
}

access_rights_for_resource(role, resource) = {
    "resource": resource,
    "access": "edit"
} {
    contains(data.roles[role].edit, resource)
}

access_rights_for_resource(role, resource) = {
    "resource": resource,
    "access": "none"
} {
    not contains(data.roles[role].view, resource)
    not contains(data.roles[role].edit, resource)
}

contains(arr, elem) {
    elem = arr[_]
}