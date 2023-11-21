# OPAL server and client
How to run the OPAL-server and OPAL-client to read the policies from the GitHub repository

## Repo Structure
    .
    └─ policies
         ├─ data.json   - Policy data 
         └─ policy.rego - Script for selecting policies on demand

CAUTION! The public github repository must be used

## The docker-compose configuration (docker-compose.yml)
Specify the URL of your public github repo in docker-compose.yml: 
* `OPAL_POLICY_REPO_URL=https://github.com/vladimir-goryunov/opal`

## Run OPAL server and client to read the policies
1. Start the Docker Desktop 
2. Run PowerShell with Admin permissions and call: 
* `docker-compose -f D:\opal-experiments\docker-compose.yml up` 
3. How to check:
* `POST request`
* `http://localhost:8181/v1/data/amp/wf`  
* `Request Body`=`{ "input": { "groups" : ["ADMIN", "USERS"]}}`