package amp.okta.integration

import future.keywords

import data.http

default allow = false

allow {
    response := http.send({"method": "GET", "url": "http://localhost:10522/weatherforecast"})
    body := http.response.body(response)
    contains(body, "success")
    printf("Response body: %v\n", [body])
}


#output contains result if {
#    some role in data.roles
#	result := {
#		debug(role)
#    }
#}
#
#debug(value) := "" if {
#	value == ""
#} else = value
