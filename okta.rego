package amp.okta

import data.roles
import data.resources

user_permissions = {
    "result": {
        "user_permissions": access_rights_for_users(input.users)
    }
}

access_rights_for_users(users) = [access_rights_for_user(user) | user := users[_]]

access_rights_for_user(user) = {
    "login": user.login,
    "accessRights": access_rights_for_groups(user.groups)
}

access_rights_for_groups(groups) = [access_rights_for_resource(role, resource) |
    role := groups[k]
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