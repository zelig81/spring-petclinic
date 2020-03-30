FROM openjdk:8-jdk-alpine3.9 as build_env

RUN apk add --no-cache bash wget curl zip unzip

ENV MAVEN_VERSION 3.6.2
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH

RUN wget https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
    mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

COPY ./mvnw /app/
COPY ./.mvn /app/.mvn

COPY ./pom.xml /app/

COPY ./src /app/src

WORKDIR /app
RUN /bin/bash ./mvnw package

FROM openjdk:8-jdk-alpine3.9
COPY --from=build_env /app/target /app

WORKDIR /app
CMD [ "java", "-jar", "*.jar"]