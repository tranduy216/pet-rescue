#!/bin/sh
#
# Gradle start up script for UN*X
#
APP_HOME=$(cd "$(dirname "$0")" && pwd)
JAVA_HOME=${JAVA_HOME:-$(dirname $(dirname $(readlink -f $(which java))))}
JAVA_EXE="$JAVA_HOME/bin/java"

CLASSPATH="$APP_HOME/gradle/wrapper/gradle-wrapper.jar"
GRADLE_WRAPPER_PROPERTIES="$APP_HOME/gradle/wrapper/gradle-wrapper.properties"

exec "$JAVA_EXE" -classpath "$CLASSPATH" org.gradle.wrapper.GradleWrapperMain "$@"
