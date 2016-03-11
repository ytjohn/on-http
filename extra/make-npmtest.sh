#!/bin/bash

CURRENT=`pwd`
BASENAME=`basename "$CURRENT"`
if [ "$BASENAME" != "on-http" ]
then
   echo "Must run from on-http"
   exit 1
fi

npm test
