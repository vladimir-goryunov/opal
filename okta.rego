package amp.okta

import future.keywords

output contains result if {
    some resourceName in data.resources
	result := {
		debug(resourceName)
    }
}

debug(value) := "" if {
	value == ""
} else = value
