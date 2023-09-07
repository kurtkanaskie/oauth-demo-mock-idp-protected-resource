@intg @error-handling
Feature: Error handling
	As an API consumer
	I want consistent and meaningful error responses
	So that I can handle the errors correctly

    @foo
    Scenario: GET /foo request not found
        When I GET /foo
        Then response code should be 404
        And response header Content-Type should be text/plain
        And response body should contain Resource not found at /foo
        
    @foobar
    Scenario: GET /foo/bar request not found
        When I GET /foo/bar
        Then response code should be 404
        And response header Content-Type should be text/plain
        And response body should contain Resource not found at /foo/bar

    @no-credentials
    Scenario: POST /token no credentials
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=client_credentials
        When I POST to /token
        Then response code should be 401

    @only-clientId
    Scenario: POST /token only clientId
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=client_credentials&client_id=`clientId`
        When I POST to /token
        Then response code should be 401
        
    @only-clientSecret
    Scenario: POST /token only clientSecret
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=client_credentials&client_secret=`clientSecret`
        When I POST to /token
        Then response code should be 401
        