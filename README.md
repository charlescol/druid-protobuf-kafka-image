# Druid with Protobuf extensions

This image is based on the official Druid image, and adds the Confluent Kafka Protobuf extensions.

It leverage Maven to resolve associated dependencies, and copy them in the Druid image.

This repository provides the solution for [apache/druid#17620](https://github.com/apache/druid/issues/17620).
