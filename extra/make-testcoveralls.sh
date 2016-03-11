#!/bin/bash

CURRENT=`pwd`
BASENAME=`basename "$CURRENT"`
if [ "$BASENAME" != "on-http" ]
then
   echo "Must run from on-http"
   exit 1
fi

./node_modules/.bin/istanbul cover -x "**/spec/**" ./node_modules/.bin/_mocha --report \ 
  lcovonly -- $(find spec -name '*-spec.js') -R spec --require spec/helper.js
cat ./coverage/lcov.info | node_modules/.bin/coveralls
