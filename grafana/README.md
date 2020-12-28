<h3>1. Install Docker-ce < 19.0v </h3>

<h3>2. Install plugin Loki for Docker and restart service</h3>
<pre>sudo docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions</pre>

<h3>3. Write to docker-compose.yml</h3>

<pre>   logging:
      driver: loki
      options:
        loki-url: http://192.168.0.19:3100/loki/api/v1/push
        loki-external-labels: job=smp-kerb-serv,owner=smp,environment=preprod
</pre>
