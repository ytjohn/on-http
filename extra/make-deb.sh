#!/bin/bash

CURRENT=`pwd`
BASENAME=`basename "$CURRENT"`
if [ "$BASENAME" != "on-http" ]
then
   echo "Must run from on-http"
   exit 1
fi

BRANCH=$(git symbolic-ref --short -q HEAD)

npm prune --production
pushd ./swagger-codegen && mvn package && popd
java -jar ./swagger-codegen/modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate -i static/monorail.yml -o on-http-api1.1
 -l python --additional-properties packageName=on_http_api1_1
java -jar ./swagger-codegen/modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate -i static/monorail-2.0.yaml -o on-http-a
pi2.0 -l python --additional-properties packageName=on_http_api2_0
java -jar ./swagger-codegen/modules/swagger-codegen-cli/target/swagger-codegen-cli.jar generate -i static/redfish.yaml -o on-http-redfis
h-1.0 -l python --additional-properties packageName=on_http_redfish_1_0
./build-package.bash python-client "${BRANCH}" "on-http-api1.1"
./build-package.bash python-client "${BRANCH}" "on-http-api2.0"
./build-package.bash python-client "${BRANCH}" "on-http-redfish-1.0"
./build-package.bash on-http "${BRANCH}"
mkdir deb && cp -a *.deb deb/
