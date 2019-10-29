FROM hub.k8s.com/kubernetes/openjdk:8u212-jre-alpine

COPY target/cronjob-demo-1.0-SNAPSHOT.jar /cronjob-demo.jar

ENTRYPOINT ["java", "-cp", "/cronjob-demo.jar", "com.mooc.demo.cronjob.Main"]
