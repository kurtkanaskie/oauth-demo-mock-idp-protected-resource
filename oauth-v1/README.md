# OAuth V2 Proxy 
Supports Client Credentials and Password Grant flows with an external IdP.\
Used with [mock-idp](../mock-idp/README.md) and for [pingstatus-v1-oauth](../pingstatus-v1-oauth/README.md) proxies.

**NOTE:** \
The KVM associated with this proxy has hard coded credentials from the `mock-ipd-app-dev`.\
This simulates a dedicated external IdP application representing Apigee as the App to the IdP.

## All at once
Create proxy, product and app (only do app once since keys are used as the IdP keys in config for oauth-v1 proxy)
```
export PROFILE=dev
mvn -P $PROFILE install
```

### Export Apps and run the tests for iterations
```
mvn -P $PROFILE \
    process-resources \
    apigee-config:exportAppKeys \
    frontend:npm@integration \
    -Dapigee.config.exportDir=target/test/integration \
    -Dskip.clean=true \
    -Dapi.testtag=@intg
```

### Iterate tests after Apps have been exported
```
mvn -P $PROFILE \
    resources:copy-resources@copy-resources \
    replacer:replace@replace \
    frontend:npm@integration \
    -Dskip.clean=true \
    -Dapi.testtag=@intg
```

#### Find the test tags
```
find test -name *.feature -exec grep @ {} \;kk
@intg @error-handling
    @foo
    @no-credentials
    @only-clientId
    @only-clientSecret
    @no-credentials-pw
    @no-client-secret-pw
    @no-client-id-pw
    @no-user-info
    @invalid-user-info
@intg @health
    @client_credentials
    @password
    @refresh
    @token-info
    @token-info
```

### Skip Creating Apps and Overwrite latest revision
Use after -Dskip.clean=true otherwise Apps won't be available
```
mvn -P $PROFILE install \
    -Dapigee.config.options=update \
    -Dapigee.options=update \
    -Dskip.apps=true \
    -Dapigee.config.dir=target/resources/edge \
    -Dapigee.config.exportDir=target/test/integration \
    -Dskip.clean=true
```

### Other discrete mvn commands
```
mvn -P dev resources:copy-resources@copy-resources replacer:replace@replace apigee-config:keyvaluemaps -Dskip.clean=true
mvn -P $PROFILE validate # (runs all validate phases: lint, apigeelint)
mvn -P $PROFILE frontend:npm@apigeelint
mvn -P $PROFILE frontend:npm@integration
```

### Other discrete npm commands
```
node ./node_modules/@cucumber/cucumber/bin/cucumber-js target/test/integration/features/health.feature --format @cucumber/pretty-formatter --publish-quiet
npm run apigeelint -- --excluded PO003 # Excludes check for body before Extract Variables
npm run integration -- --tags @health
```
