##Example script from M102 Course
#!/bin/bash

mkdir shardA_1
mkdir shardA_2
mkdir shardA_3

mkdir shardB_1
mkdir shardB_2
mkdir shardB_3

mkdir shardC_1
mkdir shardC_2
mkdir shardC_3

mkdir config1
mkdir config2
mkdir config3

mongod --configsvr --dbpath config1 --port 31001 --logpath config1/1.log --fork
mongod --configsvr --dbpath config2 --port 31002 --logpath config2/2.log --fork
mongod --configsvr --dbpath config3 --port 31003 --logpath config3/3.log --fork

mongod --shardsvr --replSet rs_shardA --dbpath shardA_1 --port 30001 --smallfiles --logpath shardA_1/1.log --fork
mongod --shardsvr --replSet rs_shardA --dbpath shardA_2 --port 30002 --smallfiles --logpath shardA_2/2.log --fork
mongod --shardsvr --replSet rs_shardA --dbpath shardA_3 --port 30003 --smallfiles --logpath shardA_3/3.log --fork

mongod --shardsvr --replSet rs_shardB --dbpath shardB_1 --port 30004 --smallfiles --logpath shardB_1/1.log --fork
monogd --shardsvr --replSet rs_shardB --dbpath shardB_2 --port 30005 --smallfiles --logpath shardB_2/2.log --fork
mongod --shardsvr --replSet rs_shardB --dbpath shardB_3 --port 30006 --smallfiles --logpath shardB_3/3.log --fork

mongod --shardsvr --replSet rs_shardC --dbpath shardC_1 --port 30007 --smallfiles --logpath shardC_1/1.log --fork
mongod --shardsvr --replSet rs_shardC --dbpath shardC_2 --port 30008 --smallfiles --logpath shardC_2/2.log --fork
mongod --shardsvr --replSet rs_shardC --dbpath shardC_3 --port 30009 --smallfiles --logpath shardC_3/3.log --fork

mongos --configdb M202:31001,M202:31002,M202:31003~ --logpath mongos.log --fork
mongos --configdb M202:31001,M202:31002,M202:31003~ --logpath mongos.log --fork --port 27018
mongos --configdb M202:31001,M202:31002,M202:31003~ --logpath mongos.log --fork --port 27019

