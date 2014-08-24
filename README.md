
# Tomcat 8 Docker Image

A docker image for Tomcat 8 and Oracle JDK 7.

Map the directory containing your war files into the container under `/deploy`,
using volumes. For example:

```bash
$ docker run -p 8080:8080 -v $(pwd)/target/myapp.war:/deploy:ro ericweikl/tomcat8
```

This image is heavily inspired by those at
https://github.com/ConSol/docker-appserver. However, I wanted to use the Oracle
JDK and a dedicated Tomcat user.
