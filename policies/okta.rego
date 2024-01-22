package amp.okta

import future.keywords

permissions contains resource if {
    # Now this is a single object!!!
	user := input.users[_]

	some resourceName in data.policies.resources

	resource := {
		"resource": resourceName,
		"access": access(resourceName, user, data.policies.roles)
	}
}

access(resourceName, user, roles) = result {
    some role
    role in user.groups
    resourceName in roles[role][_]["edit"]
    result := "edit"
} else = "view" {
    some role
    role in user.groups
    resourceName in roles[role][_]["view"]
} else = "deny"