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
#RUN \
  #echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  #add-apt-repository -y ppa:webupd8team/java && \
  #apt-get update && \
  #apt-get install -y oracle-java8-installer && \
  #rm -rf /var/lib/apt/lists/* && \
  #rm -rf /var/cache/oracle-jdk8-installer
RUN apt-get update 
RUN apt-get install -y maven
  
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
#ADD src /root/src  
#RUN mvn package

#EXPOSE 4567  
#CMD ["/usr/lib/jvm/java-8-openjdk-amd64/bin/java", "-jar", "target/sparkexample-jar-with-dependencies.jar"]  

# Define default command.
CMD ["bash"]




