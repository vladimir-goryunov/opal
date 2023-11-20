package amp.wf

import future.keywords

permissions contains resource if {
	some resourceName in data.resources
	resource := {
		"resource": resourceName
	}
}