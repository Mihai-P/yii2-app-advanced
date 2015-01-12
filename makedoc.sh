#!/bin/sh
APPNAME='My Application Name Goes Here'

mkdir -p ./reports
mkdir -p ./documents/apigen

if [ -z "$1" ]; then
    apigen \
    --title "$APPNAME API documentation" \
    --source ./backend/controllers \
    --source ./backend/models \
    --source ./common/controllers \
    --source ./common/models \
    --source ./console/controllers \
    --source ./console/models \
    --source ./frontend/controllers \
    --source ./frontend/models \
    --source ./frontend/widgets \
    --destination ./documents/apigen \
    --report ./reports/apigen.xml

#
# Left here for further expansion, ignore this for the time being.
#
elif [ "$1" = "eway" ]; then
    apigen \
    --title 'Omnipay and eWay Gateway API documentation' \
    --source ./vendor/tez/omnipay-eway/src \
    --source ./vendor/omnipay/common/src \
    --source ./vendor/omnipay/eway/src \
    --destination ./documents/apigen \
    --report ./reports/apigen.xml

fi
