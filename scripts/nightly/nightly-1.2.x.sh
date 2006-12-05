#!/bin/bash

TODAY=`date +%Y%m%d`
TARGET_BASE=people.apache.org:/www/people.apache.org/builds/struts/nightlies/

echo '##################  1.2.x  #######################################'
BUILD_LOG=struts-1.2.x-$TODAY-build.log
STRUTS=STRUTS_1_2_BRANCH-$TODAY
TARGET_URL=$TARGET_BASE/1.2.x

svn co http://svn.apache.org/repos/asf/struts/struts1/branches/STRUTS_1_2_BRANCH/ STRUTS_1_2_BRANCH-$TODAY 
cd $STRUTS
ant download-dependencies nightly > $BUILD_LOG

scp release/upload/*bin* $TARGET_URL/binary  
scp release/upload/*lib* $TARGET_URL/lib
scp release/upload/*src* $TARGET_URL/src  
scp $BUILD_LOG           $TARGET_URL/logs
scp -r target/documentation/ $TARGET_URL/
cd -

if [ "$1" = "-keep" ]; then
        echo "You specified to keep the local files with '-keep'"
        exit
fi
rm -fr STRUTS_1_2_BRANCH-$TODAY



