#!/bin/bash

# install some java, remove this if you have a better way (like puppet, chef)
yum -y install java-1.7.0-openjdk

# This is an old style init script since it was developed against cent6.. 
# newer distros need to use the right init scheme 
cp ext/webrockit-checksync.init /etc/init.d/webrockit-checksync
mkdir /opt/webrockit-checksync/logs
chmod 755 /etc/init.d/webrockit-checksync
chkconfig webrockit-checksync on
/etc/init.d/webrockit-checksync restart
