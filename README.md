# ONAP MUSIC Development Environment Container
Dockerized version ONAP MUSIC development environment. Single container including MUSIC, Zookeeper, Cassandra single node installation and aptly configured.

Simply clone the repo & hit `sudo docker build ./ -t"music-dev:beta"` which will result in a single docker image that contains all the dependencies for a single node music installation needed for development purpose.

### Update 6/30:
<table> <tr><td bgcolor=#DAF7A6>
  Check the <b>development</b> branch for updated code. Will be merged with master post some tests
  </td></tr></table>

## Quick start

Clone the repo & init

```
git clone https://github.com/kspviswa/onap-music-dev
cd onap-music-dev/music
```

### Note :
<table> <tr><td bgcolor=#DAF7A6>
Following are needed to build your own docker image. I'm planning to push a fully cooked docker image ( ~850MB ) in dockerhub. Post which, you can simple do <code> sudo docker pull kspviswa/onap-music-dev:beta </code> and that's it. <br> Please stay tuned for more updates.
  </td></tr></table>

Download Zookeeper, Cassandra, Tomcat & Maven and fix the symlink

```
ln -s ./apache-cassandra-n.n.n cassandra
ln -s ./zookeeper-n.n.n zookeeper
ln -s ./apache-tomcat-n.n.n tomcat
```

Now clone the MUSIC code from ONAP Gerrit

```
git clone https://gerrit.onap.org/r/music
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
