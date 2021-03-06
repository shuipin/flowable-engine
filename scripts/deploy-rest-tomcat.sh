#!/bin/bash

ORIGINAL_FOLDER=$(pwd)
export MAVEN_OPTS="-Xms521M -Xmx1024M -noverify"
cd ..
mvn -T 1C -PbuildRestappDependencies clean install
STATUS=$?
if [ $STATUS -eq 0 ] 
then
   	cd modules/flowable-webapp-rest2
   	echo "Undeploying any previously deployed flowable REST web application"
   	mvn tomcat7:undeploy
   	echo "Deploying latest version of flowable REST web application"
   	mvn clean package tomcat7:deploy    	
else
   	echo "Build failure in dependent project. Cannot boot Flowable Rest."
fi    