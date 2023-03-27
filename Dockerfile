#docker build -t gcviewer .
#docker run -i gcviewer -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix
FROM maven:3.6.0-jdk-11-slim AS build
RUN apt-get update && apt-get install -y git
#RUN apt-get update && apt-get install -y xvfb
WORKDIR /home/app
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -Dmaven.test.failure.ignore=true

#
# Package stage
#
FROM openjdk:8-jre-slim
COPY --from=build /home/app/target/gcviewer-1.37-SNAPSHOT.jar /usr/local/lib/gcviewer-1.37-SNAPSHOT.jar
#EXPOSE 8080
#ENV DISPLAY :10
#CMD ["java","-jar","/usr/local/lib/gcviewer-1.37-SNAPSHOT.jar"]
ENTRYPOINT ["java","-jar","/usr/local/lib/gcviewer-1.37-SNAPSHOT.jar"]

#FROM openjdk:latest
#COPY --from=build /home/app/target/gcviewer-1.37-SNAPSHOT.jar /usr/local/lib/gcviewer-1.37-SNAPSHOT.jar
#EXPOSE 8080
#ENV DISPLAY=:1
#CMD ["sh", "-c", "xvfb :1 -screen 0 1024x768x16 & java -jar /usr/local/lib/gcviewer-1.37-SNAPSHOT.jar"]