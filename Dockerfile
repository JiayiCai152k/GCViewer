FROM maven:3.6.0-jdk-11-slim AS build
RUN apt-get update && apt-get install -y git
WORKDIR /home/app
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -Dmaven.test.failure.ignore=true

#
# Package stage
#
FROM openjdk:8-jre-slim
COPY --from=build /home/app/target/gcviewer-1.37-SNAPSHOT.jar /usr/local/lib/gcviewer-1.37-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/gcviewer-1.37-SNAPSHOT.jar"]