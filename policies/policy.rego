package amp.wf

import future.keywords

permissions contains resource if {

	some resourceName in data.resources
	some token in input[_]
	resource := {
		"resource": resourceName
		#"access": access(resourceName, token, data.roles)
	}
}

access(resourceName, token, roles) := "edit" if {
    some role in token.groups[_]
    resourceName in roles[role][_]["edit"]
} else := "view" if {
    some role in token.groups[_]
    resourceName in roles[role][_]["view"]
} else := "view"