@intg @errorHandling
Feature: Error handling
	As an API consumer
	I want consistent and meaningful error responses
	So that I can handle the errors correctly

    @foo
    Scenario: GET /foo request not found
        Given I GET /foo
        Then response code should be 404
        And response header Content-Type should be application/json
        And response body path $.error should be Not found GET /pingstatus-mock/v1/foo
        
    @400
    Scenario: GET /400 request not found
        Given I GET /400
        Then response code should be 400
        And response header Content-Type should be application/json
        And response body path $.status should be ERROR

    @404
    Scenario: GET /404 request not found
        Given I GET /404
        Then response code should be 404
        And response header Content-Type should be application/json
        And response body path $.status should be ERROR