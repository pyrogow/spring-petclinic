FROM anapsix/alpine-java
LABEL maintainer="pyrogow@gmail.com" 
COPY /target/*.jar ~


# maven:3.6.2-jdk-8-openj9

# /var/lib/jenkins/workspace/petclinic-pipeline@2/target/*.jar /~/spring-petclinic-phase3-job1