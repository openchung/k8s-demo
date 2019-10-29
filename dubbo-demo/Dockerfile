FROM hub.k8s.com/kubernetes/openjdk:8u212-jre-alpine

COPY target/ROOT /ROOT

ENTRYPOINT ["sh", "/ROOT/bin/start.sh"]
