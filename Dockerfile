############################################################
# Dockerfile to build MongoDB container images
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER sanket atre

# Add a repo where OpenJDK can be found.
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java


# Auto-accept the Oracle JDK license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

RUN apt-get install -y oracle-java8-installer
