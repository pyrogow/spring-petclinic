FROM anapsix/alpine-java
LABEL maintainer="pyrogow@gmail.com" 
COPY /target/*.jar /home/spring-petclinic-phase3-job1.jar 


# maven:3.6.2-jdk-8-openj9