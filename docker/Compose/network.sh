#!/bin/bash

docker network create --driver=bridge --subnet=192.168.20.0/20 --ip-range=192.168.20.0/24 --gateway=192.168.20.1  mediawiki
