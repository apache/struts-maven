#!/bin/bash

TODAY=`date +%Y%m%d`
TARGET_BASE=people.apache.org:/www/people.apache.org/builds/struts/nightlies

echo '##################  Tiles 2.0.x  #######################################'
BUILD_LOG=./tiles-2.x-$TODAY-build.log
PROJECT=tiles-2.x-$TODAY 
TARGET_URL=$TARGET_BASE/tiles

svn co https://svn.apache.org/repos/asf/struts/sandbox/trunk/tiles/ $PROJECT
cd $PROJECT
mvn install > $BUILD_LOG


for file in $(ls tiles-core/target/*.jar);
do
   BASE_NAME=`basename $file .jar`
   scp $file  $TARGET_URL/$BASE_NAME-$TODAY.jar 
done

scp $BUILD_LOG           $TARGET_URL/logs

cd -

if [ "$1" = "-keep" ]; then
        echo "You specified to keep the local files with '-keep'"
        exit
fi
rm -fr $PROJECT




