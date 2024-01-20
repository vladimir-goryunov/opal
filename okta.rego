package amp.okta

token := t {
    response := http.send({
        "url": "https://www.google.com",
        "method": "POST",
        "headers": {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": concat(" ", [
                "Basic",
                base64.encode(sprintf("%v:%v", [client_id, client_secret]))
            ]),
        },
        # To use the resource owner password credentials flow, change grant_type
        # to "password" and add username and password parameters to the body
        "raw_body": "grant_type=client_credentials",
        "force_cache": true,
        "force_cache_duration_seconds": 3595, # Given an `expires_in` value of 3600
    })
    response.status_code == 200

    t := response.body.access_token
}