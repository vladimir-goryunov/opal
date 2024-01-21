package amp.wf

import future.keywords

permissions contains resource if {
	some resourceName in data.roles
	resource := {
		"resource": resourceName
	}
}