/* jslint node: true */
'use strict';
var calloutApickli = require('apickli');

const {Before, Given, When, Then} = require('@cucumber/cucumber');


Given(/^I have a valid client_credentials grant access token$/, function (callback) {
    var oauthDomain = this.apickli.scenarioVariables["oauthDomain"];
    var oauthBasepath = this.apickli.scenarioVariables["oauthBasepath"];
    var clientId = this.apickli.scenarioVariables["clientId"];
    var clientSecret = this.apickli.scenarioVariables["clientSecret"];
    
    var callout = new calloutApickli.Apickli('https', oauthDomain + oauthBasepath);
    callout.addHttpBasicAuthorizationHeader(clientId,clientSecret);
    callout.addRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    callout.setRequestBody("grant_type=client_credentials");
    
    var self = this;
    // console.log( "Edge: " + oauthDomain + oauthBasepath );
    callout.post("/token", function (error, response) {
        // console.log( "RESPONSE: " + JSON.stringify(response));
        if (error) {
            callback(new Error(error));
        }
        var access_token = callout.getAccessTokenFromResponseBodyPath("$.access_token");
        var externalAccessToken = callout.getAccessTokenFromResponseBodyPath("$.externalAccessToken");
        // console.log( "EDGE TOKEN: " + access_token + " externalAccessToken: " + externalAccessToken);
        self.apickli.setAccessToken(access_token);
        self.apickli.setBearerToken();
        callback();
    });
});

Given(/^I have a valid password grant access token$/, function (callback) {
    var oauthDomain = this.apickli.scenarioVariables["oauthDomain"];
    var oauthBasepath = this.apickli.scenarioVariables["oauthBasepath"];
    var clientId = this.apickli.scenarioVariables["clientId"];
    var clientSecret = this.apickli.scenarioVariables["clientSecret"];

    var userUsername = this.apickli.scenarioVariables["userUsername"];
    var userPassword = this.apickli.scenarioVariables["userPassword"];
    
    var callout = new calloutApickli.Apickli('https', oauthDomain + oauthBasepath);
    callout.addHttpBasicAuthorizationHeader(clientId,clientSecret);
    callout.addRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    callout.setRequestBody("grant_type=password&username=" + userUsername + "&password=" + userPassword);
    
    var self = this;
    // console.log( "Edge: " + oauthDomain + oauthBasepath );
    callout.post("/token", function (error, response) {
        // console.log( "RESPONSE: " + JSON.stringify(response));
        if (error) {
            callback(new Error(error));
        }
        var access_token = callout.getAccessTokenFromResponseBodyPath("$.access_token");
        var externalAccessToken = callout.getAccessTokenFromResponseBodyPath("$.externalAccessToken");
        // console.log( "EDGE TOKEN: " + access_token + " externalAccessToken: " + externalAccessToken);
        self.apickli.setAccessToken(access_token);
        self.apickli.setBearerToken();
        callback();
    });
});
