FROM maven:3.6.0-jdk-11 as build
RUN apt-get update && apt-get install -y git
WORKDIR /home/app
COPY src /home/app/src
COPY pom.xml /home/app

RUN mvn -f /home/app/pom.xml clean package -Dmaven.test.failure.ignore=true -Djava.awt.headless=true
FROM openjdk:8-jre

RUN apt update && apt install libxext6 libxrender1 libxtst6 libxi6 xvfb -y
COPY --from=build /home/app/target/gcviewer-1.37-SNAPSHOT.jar /usr/local/lib/gcviewer-1.37-SNAPSHOT.jar
ENV DISPLAY :10
VOLUME /tmp/.X11-unix

# $ docker build . -t gcv
# $ docker run -d gcv
# output the container id
# $ docker cp [container id]:/usr/local/lib/gcviewer-1.37-SNAPSHOT.jar .
# $ java -jar gcviewer-1.37-SNAPSHOT.jar