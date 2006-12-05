#!/bin/bash

TODAY=`date +%Y%m%d`
TARGET_BASE=people.apache.org:/www/people.apache.org/builds/struts/nightlies/

echo '##################  1.3.x  #######################################'
BUILD_LOG=struts-1.3.x-$TODAY-build.log
STRUTS=struts-1.3.x-$TODAY 
TARGET_URL=$TARGET_BASE/1.3.x

svn co http://svn.apache.org/repos/asf/struts/struts1/trunk/ $STRUTS
cd $STRUTS
mvn install > $BUILD_LOG

for file in $(find . -name *.jar);
do
   BASE_NAME=`basename $file .jar`
   scp $file  $TARGET_URL/$BASE_NAME-$TODAY.jar 
done

mvn -Papps install >> $BUILD_LOG

for file in $(find . -name *.war);
do
   BASE_NAME=`basename $file .war`
   scp $file  $TARGET_URL/apps/$BASE_NAME-$TODAY.war 
done


scp $BUILD_LOG           $TARGET_URL/logs

cd -

if [ "$1" = "-keep" ]; then
        echo "You specified to keep the local files with '-keep'"
        exit
fi
rm -fr $STRUTS

