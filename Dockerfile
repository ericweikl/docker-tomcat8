FROM hanswesterbeek/google-debian-oracle-jdk:8

MAINTAINER Eric Weikl <eric.weikl@gmx.net>

ENV TOMCAT_VERSION 8.0.9
ENV CATALINA_HOME /opt/tomcat

RUN wget -q -O /tmp/apache-tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

RUN mkdir ${CATALINA_HOME} \
    && tar zxf /tmp/apache-tomcat.tar.gz --strip=1 -C ${CATALINA_HOME} \
    && rm /tmp/apache-tomcat.tar.gz \
    && rm -rf ${CATALINA_HOME}/webapps/examples ${CATALINA_HOME}/webapps/docs

ADD tomcat-users.xml ${CATALINA_HOME}/conf/
ADD deploy-and-run.sh ${CATALINA_HOME}/bin/

RUN groupadd -r tomcat -g 433 \
    && useradd -u 431 -r -g tomcat -d ${CATALINA_HOME} -s /bin/nologin -c 'Tomcat User' tomcat \
    && chown -R tomcat:tomcat ${CATALINA_HOME} \
    && chmod 755 ${CATALINA_HOME}/bin/deploy-and-run.sh

USER tomcat

ENV HOME /opt/tomcat
EXPOSE 8080
CMD ${CATALINA_HOME}/bin/deploy-and-run.sh
