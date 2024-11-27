# Ping and Status OAuth protected resources
Used with [pingstatus-v1-mock](../pingstatus-v1-mock/README.md), [oauth-v1](../oauth-v1/README.md) and [idp-v1-mock](../idp-v1-mock/README.md) proxies.

## All at once
Create proxy, product and app (only do app once since keys are used as the IdP keys in config for oauth-v1 proxy)
```
export PROFILE=dev
mvn -P  $PROFILE -Dbearer=$(gcloud auth print-access-token)install
```

### Export Apps and run the tests for iterations
```
mvn -P $PROFILE -Dbearer=$(gcloud auth print-access-token) \
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
@intg @errorHandling
    @foo
    @foo-auth-client-credentials
    @foo-auth-password
    @custom-error
@intg @health
    @get-ping-client-credentials
    @get-status-client-credentials
    @get-ping-password
    @get-status-password
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
mvn -P test resources:copy-resources replacer:replace apigee-config:resourcefiles apigee-config:targetservers -Dapigee.config.dir=target/resources/edge -Dskip.clean=true 
```

### Other discrete npm commands
```
npm run apigeelint -- --excluded PO003 # Excludes check for body before Extract Variables
npm run integration -- --tags @health
```
