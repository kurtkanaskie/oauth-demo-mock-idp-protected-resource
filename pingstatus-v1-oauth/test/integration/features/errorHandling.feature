@intg @errorHandling
Feature: Error handling
	As an API consumer
	I want consistent and meaningful error responses
	So that I can handle the errors correctly

    @foo
    Scenario: GET /foo request not found
        When I GET /foo
        Then response code should be 401
        And response header Content-Type should be application/json
        And response body path $.message should be Invalid Access Token
    
    @foo-auth-client-credentials
    Scenario: GET /foo request not found
        Given I have a valid client_credentials grant access token
        When I GET /foo
        Then response code should be 404
        And response header Content-Type should be application/json
        And response body path $.message should be No resource for GET /foo
        
    @foo-auth-password
    Scenario: GET /foo/bar request not found
        Given I have a valid password grant access token
        When I GET /foo/bar
        Then response code should be 404
        And response header Content-Type should be application/json
        And response body path $.message should be No resource for GET /foo/bar

    @custom-error
    Scenario: GET /foo custom error handling
        Given I GET /foo
        Then I should get a 401 error with message "Invalid Access Token" and code 401.001