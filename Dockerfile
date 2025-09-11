FROM maven:3-eclipse-temurin-17 AS resolver
WORKDIR /tmp/app

RUN cat > pom.xml <<'EOF'
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>dummy</groupId><artifactId>dummy</artifactId><version>1.0.0</version>
  <dependencies>
    <dependency>
      <groupId>io.confluent</groupId>
      <artifactId>kafka-protobuf-provider</artifactId>
      <version>6.2.15</version>
    </dependency>
  </dependencies>
  <repositories>
    <repository><id>confluent</id><url>https://packages.confluent.io/maven/</url></repository>
    <repository><id>central</id><url>https://repo1.maven.org/maven2/</url></repository>
  </repositories>
</project>
EOF

RUN mvn -q -Dmaven.repo.local=/tmp/.m2 dependency:copy-dependencies -DoutputDirectory=/deps -DincludeScope=runtime

FROM apache/druid:34.0.0

RUN mkdir -p /opt/druid/extensions/druid-protobuf-extensions

COPY --from=resolver /deps/*.jar /opt/druid/extensions/druid-protobuf-extensions/