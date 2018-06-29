#!/bin/bash

MUSIC_ROOT=/opt/app/music
CATALINA_HOME=$MUSIC_ROOT/tomcat
ZOOKEEPER_HOME=$MUSIC_ROOT/zookeeper
CASSANDRA_HOME=$MUSIC_ROOT/cassandra
MAVEN_HOME=$MUSIC_ROOT/maven

start_tomcat() {
   $CATALINA_HOME/bin/startup.sh
}

stop_tomcat() {
   $CATALINA_HOME/bin/shutdown.sh
}

stop_cassandra() {
   pgrep -u `whoami` -f cassandra | xargs kill -9
}

start_cassandra() {
   $CASSANDRA_HOME/bin/cassandra >2
}

start_zookeeper() {
   $ZOOKEEPER_HOME/bin/zkServer.sh start
}

build_music() {
   cd $MUSIC_ROOT/music
   $MAVEN_HOME/bin/mvn -s $MUSIC_ROOT/etc/settings.xml -l $MUSIC_ROOT/logs/mvn.log clean package
   cp target/MUSIC.war $CATALINA_HOME/webapps
}

interactive_loop() {
   while true; do echo 'Hit CTRL+C'; sleep 1; done
}

echo "Starting Tomcat..."
start_tomcat
#stop_tomcat

echo "Starting Cassandra..."
start_cassandra
#stop_cassandra

echo "Starting Zookeeper..."
start_zookeeper

echo "Build & Start MUSIC..."
build_music

echo "Your MUSIC Dev environment is up & running..."
echo ""
echo "SSH into your container now..."
echo "sudo docker exec -it <Container ID> /bin/bash"
interactive_loop
