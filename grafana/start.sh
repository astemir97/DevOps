#!/bin/bash


cd ./images

sudo docker load --input ita-cadvisor.tar.gz
sudo docker load --input ita-grafana.tar.gz
sudo docker load --input ita-influxdb.tar.gz
sudo docker load --input ita-loki.tar.gz
sudo docker load --input ita-prometheus.tar.gz
sudo docker load --input ita-redis.tar.gz
sudo docker load --input ita-telegraf.tar.gz

cd ../

sudo docker-compose up -d
