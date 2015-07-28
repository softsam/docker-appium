FROM debian:latest

MAINTAINER softsam

# Install all dependencies
RUN apt-get update && \
    apt-get install -y wget python make g++ openjdk-7-jre-headless libc6-i386 lib32stdc++6 lib32z1 supervisor && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create applicative user
RUN useradd -m -s /bin/bash appium
USER appium

# Install android tools + sdk
ENV ANDROID_HOME /home/appium/android-sdk-linux
ENV ANDROID_SDK_HOME /home/appium/.android
RUN wget -qO- "http://dl.google.com/android/android-sdk_r24.3.3-linux.tgz" | tar -zx -C /home/appium && \
    echo y | ${ANDROID_HOME}/tools/android update sdk  --no-ui --all --filter platform-tools,build-tools-22.0.1 --force

# Install NodeJs
ENV node_version v0.12.7
RUN wget -qO- -P /home/appium https://nodejs.org/dist/${node_version}/node-${node_version}.tar.gz | tar -zx -C /home/appium && \
    cd /home/appium/node-${node_version}/ && ./configure --prefix=/home/appium/apps && make && make install && \
    rm -rf /home/appium/node-${node_version} /tmp/*

# Install appium
ENV PATH $PATH:/home/appium/apps/bin
RUN /home/appium/apps/bin/npm install -g appium && \
    rm -rf /tmp/*

USER root

# Expose appium server
EXPOSE 4723

# Configure supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Run supervisor
CMD ["/usr/bin/supervisord"]
