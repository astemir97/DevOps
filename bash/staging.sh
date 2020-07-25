#!/bin/bash

PROJECTS_DIR=/home/gitlab-runner/

## Stages
HOSTNAME="$HOSTNAME"
STAGE_DEV="devmortgage.it-alnc.ru"
STAGE_TEST="testmortgage.it-alnc.ru"

ITA_SMP_DEV=devmortgage.ita.local
ITA_SMP_TEST=testmortgage.ita.local

## Docker-containers
KERB_LOCAL=localhost:8443
MORT_LOCAL=localhost:9090
PRC_LOCAL=localhost:9091
KERB_STAGE=smp_kerb:8443
MORT_STAGE=smp_prc:9090
PRC_STAGE=smp_prc:9091


change_on_dev() {

   echo "--- CHANGE STAGE (DEV) ---"
   find $PROJECTS_DIR \( -name "*.html" -o -name "*.yml" -o -name "*.conf" \) -print |
        xargs sed -i 's/TEST/DEV/g; s/'$ITA_SMP_TEST'/'$ITA_SMP_DEV'/g'
}

change_on_test() {

   echo "--- CHANGE STAGE (TEST) ---"
   find $PROJECTS_DIR \( -name "*.html" -o -name "*.yml" -o -name "*.conf" \) -print |
        xargs sed -i 's/DEV/TEST/g; s/'$ITA_SMP_DEV'/'$ITA_SMP_TEST'/g'
}

change_docker_links() {

   echo "--- CHANGE STAGE IN DOCKER FILES ---"
   find $PROJECTS_DIR -name "docker-compose.yml" -print |
        xargs sed -i 's/'$MORT_LOCAL'/'$MORT_STAGE'/g; s/'$PRC_LOCAL'/'$PRC_STAGE'/g'
}


### change files

if [[ $HOSTNAME == $STAGE_DEV ]]; then

   change_on_dev

elif [[ $HOSTNAME == $STAGE_TEST ]]; then

   change_on_test

fi


### change docker-links

if egrep -r -w "$MORTGAGE_LOCAL|$PRC_LOCAL" $PROJECTS_DIR >> /dev/null; then

   change_docker_links

fi
