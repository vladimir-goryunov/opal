package amp.wf

import future.keywords

user[property] := property_val if {
	token := get_token(input.token)

	some prop in ["sub", "name", "uid"]

	property_val := token[prop]
	property := prop
}

permissions contains resource if {
	token := get_token(input.token)

	some resourceName in data.policies.resources

	resource := {
		"resource": resourceName,
		"access": access(resourceName, token, data.policies.roles)
	}
}

access(resourceName, token, roles) = result {
    some role
    role in token.groups
    resourceName in roles[role][_]["edit"]
    result := "edit"
} else = "view" {
    some role
    role in token.groups
    resourceName in roles[role][_]["view"]
} else = "deny"

get_token(jwt) = payload if {
	[_, payload, _] := io.jwt.decode(jwt)
}