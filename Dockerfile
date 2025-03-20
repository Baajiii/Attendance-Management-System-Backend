# Build Stage
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app

# Copy the pom.xml first and download dependencies (faster builds)
COPY pom.xml .
RUN mvn dependency:go-offline

# Now copy the rest of the project files
COPY . .

# Build the project without running tests
RUN mvn clean package -DskipTests

# Runtime Stage
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/Attendance-System-0.0.1-SNAPSHOT.jar Attendance-System.jar

# Expose the application port
EXPOSE 8081

# Run the application
CMD ["java", "-jar", "Attendance-System.jar"]
