#
# Oracle Java 8 Dockerfile
#
# https://github.com/dockerfile/java
# https://github.com/dockerfile/java/tree/master/oracle-java8
#

# Pull base image.
FROM ubuntu:16.04

# Install Java.
RUN apt-get update
RUN apt-get install -y software-properties-common
# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  apt-get update && \
  apt-get install -y maven && \
  apt-get install -y vim && \
  #apt-get install -y tomcat8 && \
  apt-get install -y net-tools && \
  echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/default/tomcat8 
  
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Define working directory.
WORKDIR /root

#Copy pom.xml to /root

# Prepare by downloading dependencies
ADD pom.xml /root/pom.xml  
#RUN mvn dependency:resolve  
#RUN mvn verify

# Adding source, compile and package into a fat jar
ADD src /root/src  
RUN mvn package

# Get Tomcat
RUN \
  wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-8/v8.0.35/bin/apache-tomcat-8.0.35.tar.gz -O /tmp/tomcat.tgz && \
  tar xzvf /tmp/tomcat.tgz -C /opt && \
  mv /opt/apache-tomcat-8.0.35 /opt/tomcat && \
  rm /tmp/tomcat.tgz && \
  rm -rf /opt/tomcat/webapps/examples && \
  rm -rf /opt/tomcat/webapps/docs && \
  rm -rf /opt/tomcat/webapps/ROOT

# Add admin/admin user
ADD tomcat-users.xml /opt/tomcat/conf/

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8080
EXPOSE 8009
VOLUME "/opt/tomcat/webapps"
WORKDIR /opt/tomcat

# Launch Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]



#copy build war file to tomcat webapps

#RUN cp -r /root/target/hello-java-1.0.war /var/lib/tomcat8/webapps/
#RUN rm -r /var/lib/tomcat8/webapps/ROOT

# Expose the default tomcat port
#EXPOSE 8080

# Start the tomcat (and leave it hanging)
#RUN service tomcat8 start 

# Define default command.
CMD ["bash"]




