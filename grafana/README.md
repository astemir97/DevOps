<h3>1. Install Docker-ce < 19.0v </h3>

<h3>2. Install plugin Loki for Docker and restart service</h3>
<p>sudo docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions</p>

<h3>3. Write to docker-compose.yml</h3>

<p>   logging:
      driver: loki
      options:
        loki-url: http://192.168.0.19:3100/loki/api/v1/push
        loki-external-labels: job=smp-kerb-serv,owner=smp,environment=preprod
</p>
