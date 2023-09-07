@intg @health
Feature: API proxy core
	As API administrator
	I want to verify all happy paths work
	So I can be sure proxy is correct
    
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

    @refresh
    Scenario: Create refresh token
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=password&client_id=`clientId`&client_secret=`clientSecret`&username=`userUsername`&password=`userPassword`
        When I POST to /token
        Then response code should be 200
        And response header Content-Type should be application/json
        And response body should contain access_token
        And response body should contain refresh_token
        And I store the value of body path $.refresh_token as tmpToken in scenario scope
        And I set body to grant_type=refresh_token&client_id=`clientId`&client_secret=`clientSecret`&refresh_token=`tmpToken`
        When I POST to /token
        Then response code should be 200
        And response header Content-Type should be application/json
        And response body should contain access_token

    @token-info
    Scenario: Create token
        Given I set Content-Type header to application/x-www-form-urlencoded
        And I set body to grant_type=password&client_id=`clientId`&client_secret=`clientSecret`&username=`userUsername`&password=`userPassword`
        When I POST to /token
        Then response code should be 200
        And response header Content-Type should be application/json
        And response body should contain access_token
        And I store the value of body path $.access_token as tmpToken2 in global scope

    @token-info
    Scenario: Get token info
        Given I set authorization header to Bearer `tmpToken2`
        When I GET /token
        Then response code should be 200
        And response header Content-Type should be application/json
        And response body should contain access_token
        And response body path $.status should be approved

