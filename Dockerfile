FROM maven:3.8.6-openjdk-8 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM maven:3.8.6-openjdk-8-slim
COPY --from=build /target/Attendance-System-0.0.1-SNAPSHOT Attendance-System.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","Attendance-System.jar"]