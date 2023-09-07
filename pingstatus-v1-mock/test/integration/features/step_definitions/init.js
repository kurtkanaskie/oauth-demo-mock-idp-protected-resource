/* jshint node:true */
'use strict';

var apickli = require('apickli');
var config = require('../../test-config.json');
var keys = {};

console.log('CURL TO: [https://' + config.apiconfig.domain + config.apiconfig.basepath + ']');

const {Before, setDefaultTimeout} = require('@cucumber/cucumber');

setDefaultTimeout(60 * 1000); // this is in ms

Before(function(scenario, callback) {
      this.apickli = new apickli.Apickli('https', config.apiconfig.domain + config.apiconfig.basepath);
      this.apickli.storeValueInScenarioScope("apiproxy", config.apiconfig.apiproxy);
      this.apickli.storeValueInScenarioScope("basepath", config.apiconfig.basepath);
      callback();
  });


