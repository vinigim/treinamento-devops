FROM openjdk:8-jdk-alpine
ARG JAR_FILE=Delivery_and_Deployment_Java_app/spring-web-youtube/target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
