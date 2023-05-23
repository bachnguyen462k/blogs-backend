# Sử dụng ảnh cơ sở chứa Gradle
FROM gradle:7.0.2-jdk11 AS build

# Sao chép các tệp Gradle vào container
COPY build.gradle settings.gradle .
COPY gradle/ gradle/

# Sao chép mã nguồn vào container
COPY src/ src/

# Xây dựng ứng dụng
RUN gradle build

# Sử dụng ảnh cơ sở chứa JDK
FROM openjdk:11-jdk-slim

# Sao chép tệp JAR từ giai đoạn xây dựng trước
COPY --from=build /home/gradle/build/libs/*.jar app.jar

# Mở cổng 8080 để ứng dụng có thể truy cập từ bên ngoài
EXPOSE 8080

# Chạy ứng dụng khi container được khởi chạy
CMD ["java", "-jar", "app.jar"]
