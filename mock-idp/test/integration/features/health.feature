@intg @health
Feature: API proxy health
	As API administrator
	I want to monitor Apigee proxy and backend service health
	So I can alert when it is down
    
    @get-status
    Scenario: Verify the backend service is responding
        Given I GET /status
        Then response code should be 200
        And response header Content-Type should be application/json
        And response body path $.status should be OK

    @client_credentials
    Scenario: Create client_credentials token
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=client_credentials&client_id=`clientId`&client_secret=`clientSecret`
        When I POST to /token
        Then response code should be 200
        And response header Content-Type should be application/json
        And response body should contain access_token

    @password
    Scenario: Create password grant token
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=password&client_id=`clientId`&client_secret=`clientSecret`&username=`userUsername`&password=`userPassword`
        When I POST to /token
        Then response code should be 200
        And response header Content-Type should be application/json
        And response body should contain access_token