#### Download image Alpine linux from Docker.Hub ####
FROM alpine

#### Install Mysql-Server && Apache web-server #### 
RUN apk add mysql-server && \
  
  apk add apache2 && \
  mkdir /var/www
  
COPY /devops/project/
#### Start Apache web-server ####
CMD rc-service apache2 restart
