#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


# create empty environment files
echo MYSQL_ROOT_PASSWORD=ROOTPASS > "$DIR/docker-compose-tomcat-mysql/db-variables.env"
echo MYSQL_DATABASE=DBNAME >> "$DIR/docker-compose-tomcat-mysql/db-variables.env"
echo MYSQL_USER=DBUSERNAME >> "$DIR/docker-compose-tomcat-mysql/db-variables.env"
echo MYSQL_PASSWORD=DBPASSWORD >> "$DIR/docker-compose-tomcat-mysql/db-variables.env"

echo SOME_ENVIRONMENT_VAR=xyz > "$DIR/docker-compose-tomcat-mysql/web-variables.env"
echo JAVA_OPTS=-Djdbc.dbname=tomcatdbname1 -Djdbc.username=DBUSERNAME -Djdbc.password=DBPASSWORD -Djava.security.egd=file:/dev/./urandom >> "$DIR/docker-compose-tomcat-mysql/web-variables.env"

#compile (not necessary here as we do not have servlets)
#cd $DIR/WEB-INF \
#&& javac -Xlint:deprecation -Xlint:unchecked -cp /home/sk/Documents/isc/katanemimena2018/servlet-api.jar:lib/*:classes -d classes src/tuc/sk/*.java \

# build war file and put it into the docker-compose folder
cd $DIR/src/demotomcatmysql
jar -cvf ../../docker-compose-tomcat-mysql/demotomcatmysql.war *

cd $DIR
