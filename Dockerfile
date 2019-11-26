FROM anapsix/alpine-java
LABEL maintainer="pyrogow@gmail.com"
COPY /target/*.jar /home/*.jar
ENTRYPOINT ["java","-jar","/*.jar"]

# COPY target/*.jar /home/ec2-user/
# COPY *.jar /home/ec2-user/
# maven:3.6.2-jdk-8-openj9

# /var/lib/jenkins/workspace/petclinic-pipeline@2/target/*.jar /~/spring-petclinic-phase3-job1
# /var/lib/jenkins/workspace/petclinic-pipeline@2/target/Phase3_Job1-153.jar
