package amp.okta

import future.keywords


userPermissions contains permission if {
	some user in input.users

	some resourceName in data.resources
	permission := {
		"login": user.login,
		"resourceName": resourceName,
		"politics": "resource_access_placeholder"
	}
}

#	some resourceName in data.resources
#    resource := {
#        "resource": resourceName
#    }

#permissions contains resource if {
#	token := get_token(input.token)
#
#	some resourceName in data.policies.resources
#
#	resource := {
#		"resource": resourceName,
#		"access": access(resourceName, token, data.policies.roles)
#	}
#}
#
#access(resourceName, token, roles) = result {
#    some role
#    role in token.groups
#    resourceName in roles[role][_]["edit"]
#    result := "edit"
#} else = "view" {
#    some role
#    role in token.groups
#    resourceName in roles[role][_]["view"]
#} else = "deny"

#output contains result if {
#    body := "body-of-request"
#	result := {
#		debug(body)
#    }
#}

#debug(value) := "" if {
#	value == ""
#} else = value
