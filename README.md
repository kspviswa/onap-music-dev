# ONAP MUSIC Development Environment Container
Dockerized version ONAP MUSIC development environment. Single container including MUSIC, Zookeeper, Cassandra single node installation and aptly configured.

Simply clone the repo & hit `sudo docker build ./ -t"music-dev:beta"` which will result in a single docker image that contains all the dependencies for a single node music installation needed for development purpose.

## Quick start

Clone the repo & init

```
git clone https://github.com/kspviswa/onap-music-dev
cd onap-music-dev
```

Download Zookeeper, Cassandra, Tomcat & Maven and fix the symlink

```
ln -s ./apache-cassandra-n.n.n cassandra
ln -s ./zookeeper-n.n.n zookeeper
ln -s ./apache-tomcat-n.n.n tomcat
```

Run the image

```
sudo docker run -td music-dev:beta
```

Now simply get into your container and start hacking your MUSIC Dev installation. As simple as that.

```
sudo docker exec -it <Container ID> /bin/bash
```

## List of changes required to cook this image
* No change in cassandra default user/password. It is a local docker installation. No port exposed. So you can relax
* `settings.xml` is modified to use `/tmp/onap` as local repo. Hence lightweight & stateless.
* Tomcat, Cassandra & Zookeeper prestarted & preconfigured for you. Just run the container and attach the tty, then you are good to go.
