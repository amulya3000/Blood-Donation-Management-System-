#!/bin/sh

# Minimal Maven wrapper launcher for Unix-like shells.
BASEDIR=$(cd "$(dirname "$0")"; pwd)
WRAPPER_JAR="$BASEDIR/.mvn/wrapper/maven-wrapper.jar"

if [ ! -f "$WRAPPER_JAR" ]; then
  echo "[ERROR] Missing $WRAPPER_JAR" 1>&2
  exit 1
fi

if [ -n "$JAVA_HOME" ]; then
  JAVACMD="$JAVA_HOME/bin/java"
else
  JAVACMD="java"
fi

exec "$JAVACMD" -classpath "$WRAPPER_JAR" "-Dmaven.multiModuleProjectDirectory=$BASEDIR" org.apache.maven.wrapper.MavenWrapperMain "$@"
