package amp.okta.integration

import future.keywords

output contains result if {
    some role in data.roles
	result := {
		debug(role)
    }
}

debug(value) := "" if {
	value == ""
} else = value
