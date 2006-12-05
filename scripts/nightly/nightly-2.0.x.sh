#!/bin/bash

TODAY=`date +%Y%m%d`
TARGET_BASE=people.apache.org:/www/people.apache.org/builds/struts/nightlies/

echo '##################  2.0.x  #######################################'
BUILD_LOG=struts-2.0.x-$TODAY-build.log
STRUTS=struts-2.0.x-$TODAY 
XWORK=xwork-$TODAY 

TARGET_URL=$TARGET_BASE/2.0.x/

svn co http://svn.opensymphony.com/svn/xwork/trunk/ $XWORK
cd $XWORK
mvn -U install
cd -

svn co http://svn.apache.org/repos/asf/struts/struts2/trunk/ $STRUTS

cd $STRUTS
mvn -Pall deploy > $BUILD_LOG

echo Fixing Permissions .......
ssh people.apache.org 'chmod -Rf g+w /www/people.apache.org/repo/m2-snapshot-repository/org/apache/struts/'
echo Fixing Permissions .......Done

for dir in 'api core';
do
  for file in $(find $dir/ -name *.jar);
  do
    BASE_NAME=`basename $file .jar`
    scp $file  $TARGET_URL/$BASE_NAME-$TODAY.jar 
  done
done

for dir in 'plugins';
do
  for file in $(find $dir/ -name *.jar);
  do
    BASE_NAME=`basename $file .jar`
    scp $file  $TARGET_URL/plugins/$BASE_NAME-$TODAY.jar 
  done
done

for file in $(find . -name *.war);
do
  BASE_NAME=`basename $file .war`
  scp $file  $TARGET_URL/apps/$BASE_NAME-$TODAY.war 
done

RETRO_JAR=../../../Retrotranslator-1.0.7-bin/retrotranslator-transformer-1.0.7.jar 

XWORK_JAR=../xwork-$TODAY/target/xwork-2.0-SNAPSHOT.jar
XWORK_J4_JAR=xwork-j4-2.0-SNAPSHOT-$TODAY.jar

STRUTS2_JAR=core/target/struts2-core-2.0.0-SNAPSHOT.jar
STRUTS2_J4_JAR=struts-core-j4-2.0.0-SNAPSHOT-$TODAY.jar

java -jar $RETRO_JAR -srcjar $XWORK_JAR    -destjar $XWORK_J4_JAR
java -jar $RETRO_JAR -srcjar $STRUTS2_JAR  -destjar $STRUTS2_J4_JAR

scp $XWORK_J4_JAR   $TARGET_URL/java-1.4/
scp $STRUTS2_J4_JAR $TARGET_URL/java-1.4/

rm -fr backbort/.svn/
scp -r backport $TARGET_URL/java-1.4/

scp $BUILD_LOG           $TARGET_URL/logs

cd -

if [ "$1" = "-keep" ]; then
        echo "You specified to keep the local files with '-keep'"
        exit
fi
rm -fr $STRUTS
rm -fr $XWORK

