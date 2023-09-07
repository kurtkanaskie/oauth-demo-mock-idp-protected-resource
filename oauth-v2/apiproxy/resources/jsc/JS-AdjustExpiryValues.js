/* globals context */
var expiryTimeInSeconds = context.getVariable("externalExpiresIn");
var expiryTimeInMills = Number(expiryTimeInSeconds * 1000).toString();
var refreshExpiryTimeInMills = Number(expiryTimeInSeconds * 1000 * 100).toString();
context.setVariable("externalExpiresIn", expiryTimeInMills);
context.setVariable("refreshExpiresIn", refreshExpiryTimeInMills);
