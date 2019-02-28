FROM mrchnk/air-sdk:adl

LABEL description="Dockerized Apache Flex SDK (with air)"
LABEL maintainer="Nikolay Sukharev <mrchnk@gmail.com>"

ARG FLEX_SDK_VERSION=4.16.1
ARG FLEX_SDK_URL=http://mirror.linux-ia64.org/apache/flex/${FLEX_SDK_VERSION}/binaries/apache-flex-sdk-${FLEX_SDK_VERSION}-bin.tar.gz
ARG FLEX_SDK_MD5=0fba6c912c3919ae1b978ca2d053fe07

ENV FLEX_SDK_HOME ${AIR_SDK_HOME}

WORKDIR /root

RUN curl -fsSL ${FLEX_SDK_URL} -o FLEXSDK.tar.gz \
  && echo "${FLEX_SDK_MD5} *FLEXSDK.tar.gz" | md5sum -c - \
  && tar -xvf FLEXSDK.tar.gz \
  && cd apache-flex-sdk-${FLEX_SDK_VERSION}-bin \
  && cp -f -R * ${FLEX_SDK_HOME} \
  && cd .. \
  && rm -rf apache-flex-sdk-${FLEX_SDK_VERSION}-bin \
  && rm FLEXSDK.tar.gz

WORKDIR ${FLEX_SDK_HOME}

RUN ant -f installer.xml -noinput \
  -Dskip.air.install=yes -Dair.donot.ask=yes \
  -Dflash.donot.ask=yes \
  -Dfontswf.donot.ask=yes

# Additional env variables to SDK commonly used by applications
ENV FLEX_HOME ${FLEX_SDK_HOME}
ENV FLEX_SDK ${FLEX_SDK_HOME}

RUN rm /etc/java-8-openjdk/accessibility.properties

WORKDIR /
