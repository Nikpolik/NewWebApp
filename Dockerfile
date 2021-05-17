FROM ubuntu:16.04

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install default-jdk
RUN apt-get -y install wget

WORKDIR /opt

ENV DLLINK downloads.apache.org/tomcat/tomcat-10/v10.0.6/bin/
ENV TOMCAT apache-tomcat-10.0.6
ENV TOMCATTZ ${TOMCAT}.tar.gz
ENV TARGETD /opt/${TOMCAT}
ENV MYSQL_USER root
ENV MYSQL_PASSWORD root

# RUN wget https://downloads.apache.org/tomcat/tomcat-10/v10.0.5/bin/apache-tomcat-10.0.5.tar.gz 
# RUN tar -xvzf apache-tomcat-10.0.5.tar.gz

RUN wget ${DLLINK}/${TOMCATTZ}
RUN tar -xvf ${TOMCATTZ}

EXPOSE 8080

# CMD [ "/opt/apache-tomcat-10.0.5/bin/catalina.sh", "run" ]
CMD exec ${TARGETD}/bin/catalina.sh run

ENV WAR target/NewWebApp.war

ADD ${WAR} ${TARGETD}/webapps