#!/bin/sh

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

apt-get update

apt-get upgrade -y

apt-get install -y mongodb-org

mkdir /data

mkdir /data/db

mongod --dbpath /data/db --port 30001 --smallfiles --logpath /data/db/mongod1.log --fork
