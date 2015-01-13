#!/bin/sh

#
# Smart little documentation generator.
# GPL/LGPL
# (c) Del 2015 http://www.babel.com.au/
#

APPNAME='My Application Name Goes Here'
CMDFILE=apigen.cmd.$$

mkdir -p ./reports
mkdir -p ./documents/apigen

#
# Without any arguments this builds the entire system documentation,
# making the cache file first if required.
#
if [ -z "$1" ]; then
    #
    # Check to see that the cache has been made.
    #
    if [ ! -f dirlist.cache ]; then
        echo "Making dirlist.cache file"
        $0 makecache
    fi

    #
    # Build the apigen command in a file.
    #
    echo "apigen --title '$APPNAME API Documentation' --destination ./documents/apigen --report ./reports/apigen.xml \\" > $CMDFILE
    cat dirlist.cache | while read dir; do
        echo "--source $dir \\" >> $CMDFILE
    done
    echo "" >> $CMDFILE

    #
    # Run the apigen command
    #
    . ./$CMDFILE
    
    /bin/rm -f ./$CMDFILE

#
# The "makecache" argument causes the script to just make the cache file
#
elif [ "$1" = "makecache" ]; then
    echo "Find application source directories"
    find backend common console frontend -name \*.php -print | \
        (
            while read file; do
                grep -q 'class' $file && dirname $file
            done
        ) | sort -u | \
        grep -v -E 'assets|config|docs|migrations|test|Test|views|web' > dirlist.app

    echo "Find vendor source directories"
    find vendor -name \*.php -print | \
        (
            while read file; do
                grep -q 'class' $file && dirname $file
            done
        ) | sort -u | \
        grep -v -E 'assets|config|docs|migrations|test|Test|views|web' > dirlist.vendor
  
    #
    # Filter out any vendor directories for which apigen fails
    #
    echo "Filter source directories"
    cat dirlist.app dirlist.vendor | while read dir; do
        apigen --quiet --title "Test please ignore" \
            --source $dir \
            --destination ./documents/apigen \
            --report ./reports/apigen.xml && (
                echo "Including $dir"
                echo $dir >> dirlist.cache
            ) || (
                echo "Excluding $dir"
            )
    done
    echo "Documentation cache dirlist.cache built OK"


# Don't work for various reasons
# --source ./vendor/cebe/markdown duplicate trait method declared
# --source ./vendor/mpdf/mpdf/classes contains no documentation

#
# Documentation for sub-components
#
elif [ "$1" = "eway" ]; then
    apigen \
    --title 'Omnipay and eWay Gateway API documentation' \
    --source ./vendor/tez/omnipay-eway/src \
    --source ./vendor/omnipay/common/src \
    --source ./vendor/omnipay/eway/src \
    --destination ./documents/apigen \
    --report ./reports/apigen.xml

elif [ "$1" = "cms" ]; then
    apigen \
    --title 'Yii2 CMS Module API documentation' \
    --source ./vendor/tez/yii2-cms-module/components \
    --source ./vendor/tez/yii2-cms-module/controllers \
    --source ./vendor/tez/yii2-cms-module/models \
    --source ./vendor/tez/yii2-cms-module/widgets \
    --destination ./documents/apigen \
    --report ./reports/apigen.xml

fi
