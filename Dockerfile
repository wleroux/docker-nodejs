FROM phusion/baseimage:0.9.13
MAINTAINER Wayne Leroux <WayneLeroux@gmail.com>

# Set up base image
RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y dist-upgrade
ENV HOME /root
RUN echo 'LANG="en_EN.UTF-8"' > /etc/default/locale
CMD ["/sbin/my_init"]

# Support SSH
VOLUME /root/.ssh

# Install Administration Utilities
RUN apt-get -y install wget unzip git sudo zip bzip2 fontconfig curl vim

# Install Node.js
ENV NODE_VERSION v0.10.31
RUN wget -P /tmp http://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz && \
    tar xzvf /tmp/node-${NODE_VERSION}-linux-x64.tar.gz -C /opt
RUN echo 'export NODE_HOME="/opt/node-${NODE_VERSION}-linux-x64"' >> ~/.bashrc
ENV NODE_HOME /opt/node-${NODE_VERSION}-linux-x64
ENV PATH $PATH:$NODE_HOME/bin
RUN export PATH=$PATH

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

