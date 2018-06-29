#FROM ubuntu:14.04
#FROM jared314/ubuntu-14-04-java8
FROM nimmis/java:openjdk-8-jdk

MAINTAINER Viswanath Kumar Skand Priya (kspviswa.github@gmail.com) version: 0.1

ADD ./music /opt/app/music

#ENTRYPOINT /bin/bash /opt/app/music/prepare.sh
CMD ["/opt/app/music/prepare.sh"]

