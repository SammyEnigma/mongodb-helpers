#!/bin/bash

mkdir replsetA_1
mkdir replsetA_2
mkdir replsetA_3

mongod --replSet rs_A --dbpath replsetA_1 --port 30001 --smallfiles --logpath replsetA_1/1.log --fork
mongod --replSet rs_A --dbpath replsetA_2 --port 30002 --smallfiles --logpath replsetA_2/2.log --fork
mongod --replSet rs_A --dbpath replsetA_3 --port 30003 --smallfiles --logpath replsetA_3/3.log --fork