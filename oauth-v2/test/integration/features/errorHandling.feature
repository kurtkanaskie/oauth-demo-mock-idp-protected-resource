@intg @error-handling
Feature: Error handling
	As an API consumer
	I want consistent and meaningful error responses
	So that I can handle the errors correctly

    @foo
    Scenario: GET /foo request not found
        When I GET /foo
        Then response code should be 404
    
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
        
    @no-credentials-pw
    Scenario: POST /token no credentials
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=password
        When I POST to /token
        Then response code should be 401

    @no-client-secret-pw
    Scenario: POST /token only clientId
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=password&client_id=`clientId`
        When I POST to /token
        Then response code should be 401
        
    @no-client-id-pw
    Scenario: POST /token only clientSecret
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=password&client_secret=`clientSecret`
        When I POST to /token
        Then response code should be 401

    @no-user-info
    Scenario: Create password grant token
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=password&client_id=`clientId`&client_secret=`clientSecret`
        When I POST to /token
        Then response code should be 401

    @invalid-user-info
    Scenario: Create password grant token
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=password&client_id=`clientId`&client_secret=`clientSecret`&username=foo&password=bar
        When I POST to /token
        Then response code should be 401

        