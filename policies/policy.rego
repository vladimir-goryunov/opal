package amp.wf

import future.keywords

permissions contains resource if {
    token := get_token(input)

	some resourceName in data.policies.resources

	resource := {
		"resource": resourceName,
		"access": access(resourceName, token, data.policies.roles)
	}
}

access(resourceName, token, roles) := "edit" if {
    some role in token.groups
    resourceName in roles[role][_]["edit"]
} else := "view" if {
    some role in token.groups
    resourceName in roles[role][_]["view"]
} else := "unknown"

get_token(jwt) = jwt if {
	jwt != ""
}