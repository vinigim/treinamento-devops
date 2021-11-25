#!/bin/bash
cd Delivery_and_Deployment_Java_app/spring-web-youtube
mvn package -Dmaven.test.skip -DskipTests -Dmaven.javadoc.skip=true