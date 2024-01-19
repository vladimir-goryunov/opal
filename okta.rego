package amp.okta.integration

import future.keywords


userPermissions contains resource if {
	some user in input.users
	resource := {
		"user": user,
		"resource": "resource_placeholder",
		"access": "access_placeholder"
	}
}

output contains result if {
    body := "body-of-request"
	result := {
		debug(body)
    }
}

debug(value) := "" if {
	value == ""
} else = value
