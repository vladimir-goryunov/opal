package amp.wf

import future.keywords

permissions contains resource if {

	some resourceName in data.policies.resources
	#some role in input.groups
    #roles := data.policies.roles

	resource := {
		"resource": resourceName,
		#"roles[role][_]": roles[role][_],
		"access": access(resourceName, input, data.policies.roles)
	}
}

access(resourceName, token, roles) := "edit" if {
    some role in token.groups
    resourceName in roles[role][_]["edit"]
} else := "view" if {
    some role in token.groups
    resourceName in roles[role][_]["view"]
} else := "unknown"


#permissions contains resource if {
#	some resourceName in data.policies.resources
#	resource := {
#		"resource": resourceName,
#		"token": token,
#		"access": access(resourceName, input, data.policies.roles)
#		#"access": access(resourceName, token, data.policies.roles)
#	}
#}
