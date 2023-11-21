package amp.wf

import future.keywords

permissions contains resource if {

	some resourceName in data.policies.resources
	#some token in input.groups
	resource := {
		"resource": resourceName,
		"token": token,
		"access": access(resourceName, input, data.policies.roles)
		#"access": access(resourceName, token, data.policies.roles)
	}
}

access(resourceName, token, roles) := "edit" if {
    some role in token.groups
    resourceName in roles[role][_]["edit"]
} else := "view" if {
    some role in token.groups
    resourceName in roles[role][_]["view"]
} else := "unknown"