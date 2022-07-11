#!/bin/sh
mvn dependency:get -Dartifact=com.thoughtworks.xstream:xstream:1.4.19
mvn dependency:get -Dartifact=commons-io:commons-io:2.7
mvn dependency:get -Dartifact=org.apache.logging.log4j:log4j-core:2.17.1
mvn dependency:get -Dartifact=org.freemarker:freemarker:2.3.30