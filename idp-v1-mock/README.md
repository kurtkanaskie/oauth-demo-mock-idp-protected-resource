# OAuth Mock IdP
Supports Client Credentials and Password Grant flows.\
Used by [oauth-v1](../oauth-v1/README.md) proxy.

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
    @foobar
    @no-credentials
    @only-clientId
    @only-clientSecret
@intg @health
    @get-status
    @client_credentials
    @password
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
mvn -P $PROFILE validate # (runs all validate phases: lint, apigeelint)
mvn -P $PROFILE frontend:npm@apigeelint
mvn -P $PROFILE frontend:npm@integration
```

### Other discrete npm commands
```
npm run apigeelint -- --excluded PO007 # Excludes non-standard name prefixes
npm run integration -- --tags @health
```

