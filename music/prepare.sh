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
   echo "Press any key to exit..."
   read n
}

download_deps() {
   cd $MUSIC_ROOT
   wget -q --show-progress http://www-eu.apache.org/dist/cassandra/3.0.16/apache-cassandra-3.0.16-bin.tar.gz
   tar -zxvf apache-cassandra-3.0.16-bin.tar.gz
   wget -q --show-progress http://www-eu.apache.org/dist/zookeeper/current/zookeeper-3.4.12.tar.gz
   tar -zxvf zookeeper-3.4.12.tar.gz
   wget -q --show-progress http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.32/bin/apache-tomcat-8.5.32.tar.gz
   tar -zxvf apache-tomcat-8.5.32.tar.gz
   wget -q --show-progress https://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
   tar -zxvf apache-maven-3.3.9-bin.tar.gz
   
   ln -s ./apache-cassandra-3.0.16 cassandra
   ln -s ./zookeeper-3.4.12 zookeeper
   ln -s ./apache-tomcat-8.5.32 tomcat
   ln -s ./apache-maven-3.3.9 maven

   cp $MUSIC_ROOT/etc/zoo.cfg $ZOOKEEPER_HOME/conf/

   rm *.tar.gz

   git clone https://gerrit.onap.org/r/music
}

echo "Download Deps..."
download_deps
echo ""

echo "Starting Tomcat..."
start_tomcat
#stop_tomcat
echo ""

echo "Starting Cassandra..."
start_cassandra
#stop_cassandra
echo ""

echo "Starting Zookeeper..."
start_zookeeper
echo ""

echo "Build & Start MUSIC..."
build_music
echo ""

echo "Your MUSIC Dev environment is up & running..."
echo ""
echo "SSH into your container now..."
echo "sudo docker exec -it <Container ID> /bin/bash"
interactive_loop
