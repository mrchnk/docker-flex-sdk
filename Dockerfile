FROM openjdk:8-jre-slim

LABEL description="Dockerized Apache Flex SDK"
LABEL maintainer="Nikolay Sukharev <mrchnk@gmail.com>"

RUN apt-get update && \
  apt-get install -y --no-install-recommends curl ant && \
  rm -rf /var/lib/apt/lists/*

ARG FLEX_SDK_VERSION=4.16.1
ARG FLEX_SDK_URL=http://mirror.linux-ia64.org/apache/flex/${FLEX_SDK_VERSION}/binaries/apache-flex-sdk-${FLEX_SDK_VERSION}-bin.tar.gz
ARG FLEX_SDK_MD5=0fba6c912c3919ae1b978ca2d053fe07

ENV FLEX_SDK_HOME /usr/share/FLEXSDK

WORKDIR /root

RUN curl -fsSL ${FLEX_SDK_URL} -o FLEXSDK.tar.gz
RUN echo "${FLEX_SDK_MD5} *FLEXSDK.tar.gz" | md5sum -c -
RUN tar -xvf FLEXSDK.tar.gz
RUN mv apache-flex-sdk-${FLEX_SDK_VERSION}-bin ${FLEX_SDK_HOME}
RUN rm FLEXSDK.tar.gz

RUN ant -f ${FLEX_SDK_HOME}/installer.xml -noinput \
  -Dskip.air.install=yes -Dair.donot.ask=yes \
  -Dflash.donot.ask=yes \
  -Dfontswf.donot.ask=yes

ENV PATH ${FLEX_SDK_HOME}/bin:${PATH}

# Additional env variables to SDK commonly used by applications
ENV FLEX_HOME ${FLEX_SDK_HOME}
ENV FLEX_SDK ${FLEX_SDK_HOME}

WORKDIR /
