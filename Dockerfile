#docker build -t spring-boot-skeleton:latest . --no-cache
#docker run -dp 8080:8080 spring-boot-skeleton
FROM maven:3.6.0-jdk-11-slim AS build
COPY ./src /home/app/src
COPY ./pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests

FROM openjdk:11
COPY --from=build /home/app/target/*.jar /usr/local/lib/spring-boot-skeleton.jar

EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/usr/local/lib/spring-boot-skeleton.jar"]
