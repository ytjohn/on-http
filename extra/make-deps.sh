#!/bin/bash

CURRENT=`pwd`
BASENAME=`basename "$CURRENT"`
if [ "$BASENAME" != "on-http" ]
then
   echo "Must run from on-http"
   exit 1
fi


echo "Adding swagger-codegen"
if [ ! -d swagger-codegen ]; then \
    git clone --branch v2.1.5 https://github.com/swagger-api/swagger-codegen.git; \
fi

npm install
