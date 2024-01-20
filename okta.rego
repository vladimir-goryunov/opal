package amp.okta
import data.roles
import data.resources

user_permissions = {
    "result": {
        "user_permissions": [
            {
                "accessRights": access_rights_for_user(input.users[i])
            }
            |
            i < count(input.users)
        ]
    }
}

access_rights_for_user(user) = {
    "login": user.login,
    "accessRights": access_rights_for_groups(user.groups)
}

access_rights_for_groups(groups) = [access_rights(resource, role) |
    role := groups[k]
    resource := data.resources[j]
    access_rights := data.roles[role]
    role_index := k
    j < count(data.resources)
    k < count(groups)
]

access_rights(resource, role) = {
    "resource": resource,
    "access": "view"
} {
    contains(access_rights[l].view, resource)
}

access_rights(resource, role) = {
    "resource": resource,
    "access": "edit"
} {
    contains(access_rights[m].edit, resource)
}

access_rights(resource, role) = {
    "resource": resource,
    "access": "none"
} {
    not contains(access_rights[n].view, resource)
    not contains(access_rights[o].edit, resource)
}

contains(arr, elem) {
    elem = arr[_]
}