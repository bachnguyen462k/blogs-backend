FROM gradle:8.1.1-jdk11 as build

EXPOSE 8080

COPY . /app

WORKDIR /app

RUN apt-get update && \
    apt-get install -y gradle && \
    gradle build

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/build/libs/*.jar"]
