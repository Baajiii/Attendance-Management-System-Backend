FROM maven:3.8.6-openjdk-11 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim
COPY --from=build /target/Attendance-System-0.0.1-SNAPSHOT Attendance-System.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","Attendance-System.jar"]