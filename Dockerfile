FROM gradle:8.1.1-jdk11 as build

COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build

FROM openjdk:11.0.12-jre-slim
COPY --from=build /home/gradle/src/build/libs/*.jar /app/app.jar

CMD ["java", "-jar", "/app/app.jar"]
