#!/bin/sh

DIR=${DEPLOY_DIR:-/deploy}

if [ -d $DIR ]; then
  for WAR in $DIR/*.war; do
     echo "Deploying $WAR..."
     ln -s $i /opt/tomcat/webapps/$(basename $WAR)
  done
else
  echo "No deploy dir found at ${DIR} - did you forget to map a volume?"
fi

# Use faster (though less secure) random number generator
export CATALINA_OPTS="$CATALINA_OPTS -Djava.security.egd=file:/dev/./urandom"
/opt/tomcat/bin/catalina.sh run
