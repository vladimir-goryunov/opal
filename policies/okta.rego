package amp.okta

import future.keywords

permissions contains resource if {
	token := input.token

	some resourceName in data.policies.resources

	resource := {
		"resource": resourceName,
		"access": access(resourceName, token, data.policies.roles)
	}
}

access(resourceName, token, roles) = result {
    some role
    role in token.groups
    resourceName in roles[role][_]["edit"]
    result := "edit"
} else = "view" {
    some role
    role in token.groups
    resourceName in roles[role][_]["view"]
} else = "deny"