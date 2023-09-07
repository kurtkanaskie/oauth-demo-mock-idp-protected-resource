@intg @health
Feature: API proxy health
	As API administrator
	I want to monitor Apigee proxy and backend service health
	So I can alert when it is down
    
    @get-ping
    Scenario: Verify the API proxy is responding
        When I GET /ping
        Then response code should be 200
        And response header Content-Type should be application/json
        And response body path $.status should be OK

    @get-status
    Scenario: Verify the API proxy is responding
        When I GET /status
        Then response code should be 200
        And response header Content-Type should be application/json
        And response body path $.status should be OK

    @get-healthcheck
    Scenario: Verify the API proxy is responding
        When I GET /healthcheck
        Then response code should be 200
        And response header Content-Type should be application/json
        And response body path $.status should be OK
