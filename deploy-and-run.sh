#!/bin/sh

DIR=${DEPLOY_DIR:-/deploy}

if [ -d $DIR ]; then
  for WAR in $DIR/*.war; do
     # remove version numbers, e.g. MyApp-1.0.0-SNAPSHOT.war becomes MyApp.war
     FINAL="/opt/tomcat/webapps/$(basename $WAR | sed 's#-[0-9]\+\.[0-9]\+\.[0-9]\+.*\.war#.war#')"
     echo "Deploying $WAR as $FINAL..."
     ln -s $WAR /opt/tomcat/webapps/$FINAL
  done
else
  echo "No deploy dir found at ${DIR} - did you forget to map a volume?"
fi

# Use faster (though less secure) random number generator
export CATALINA_OPTS="$CATALINA_OPTS -Djava.security.egd=file:/dev/./urandom"
/opt/tomcat/bin/catalina.sh run
