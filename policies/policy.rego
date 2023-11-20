package amp.wf

import future.keywords

permissions contains resource if {
	some resourceName in data.policies["app"].resources
	resource := {
		"resource": resourceName
	}
}