package amp.okta.integration

import future.keywords

output contains result if {
	result := {
		debug("data.resources")
    }
}

debug(value) := "" if {
	value == ""
} else = value
