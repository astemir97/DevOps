#!/bin/bash

PROJECTS_DIR=/home/gitlab-runner/

## Stages
HOSTNAME="$HOSTNAME"
STAGE_DEV="devmortgage.it-alnc.ru"
STAGE_TEST="testmortgage.it-alnc.ru"

## Keberos keys & users
KERB_KEY_DEV=devmortgage.ita.local.keytab
KERB_USER_DEV=devmortgage.ita.local@ITA.LOCAL
KERB_KEY_TEST=testmortgage.ita.local.keytab
KERB_USER_TEST=testmortgage.ita.local@ITA.LOCAL

## Stagings in Domain
KERB_DEV=devmortgage.ita.local:8443
MORT_DEV=devmortgage.ita.local:9090
PRC_DEV=devmortgage.ita.local:9091
KERB_TEST=testmortgage.ita.local:8443
MORT_TEST=testmortgage.ita.local:9090
PRC_TEST=testmortgage.ita.local:9091

## Docker-containers
KERB_LOCAL=localhost:8443
MORT_LOCAL=localhost:9090
PRC_LOCAL=localhost:9091
KERB_STAGE=smp_kerb:8443
MORT_STAGE=smp_prc:9090
PRC_STAGE=smp_prc:9091


change_on_dev() {

   echo "--- CHANGE STAGE IN STATIC FILES (DEV) ---"
   grep -P -R -l -w "TEST" $PROJECTS_DIR | xargs sed -i 's/TEST/DEV/g'
   
   echo "--- CHANGE STAGE IN KERBEROS FILES (DEV) ---"
   grep -P -R -l -w "$KERB_KEY_TEST|$KERB_USER_TEST" $PROJECTS_DIR |
	 xargs sed -i 's/'$KERB_KEY_TEST'/'$KERB_KEY_DEV'/g; s/'$KERB_USER_TEST'/'$KERB_USER_DEV'/g'
 
   echo "--- CHANGE STAGE LINK IN html FILES (DEV) ---"
   grep -P -R -l -w "$KERB_SERV_TEST|$MORT_TEST|$PRC_TEST|$KERB_LOCAL"  $PROJECTS_DIR |
	 xargs sed -i 's/'$KERB_TEST'/'$KERB_SERV_DEV'/g; s/'$MORT_TEST'/'$MORT_DEV'/g;
                 s/'$PRC_TEST'/'$PRC_DEV'/g; s/'$KERB_LOCAL'/'$KERB_DEV'/g'
}

change_on_test() {

   echo "--- CHANGE STAGE IN STATIC FILES (TEST) ---"
   grep -P -R -l -w "DEV" $PROJECTS_DIR | xargs sed -i 's/DEV/TEST/g'
   
   echo "--- CHANGE STAGE IN KERBEROS FILES (TEST) ---"
   grep -P -R -l -w "$KERB_KEY_DEV|$KERB_USER_DEV" $PROJECTS_DIR |
	 xargs sed -i 's/'$KERB_KEY_DEV'/'$KERB_KEY_TEST'/g; s/'$KERB_USER_DEV'/'$KERB_USER_TEST'/g'
 
   echo "--- CHANGE STAGE LINK IN html FILES (TEST) ---"
   grep -P -R -l -w "$KERB_SERV_DEV|$MORT_DEV|$PRC_DEV|$KERB_LOCAL"  $PROJECTS_DIR |
	 xargs sed -i 's/'$KERB_DEV'/'$KERB_TEST'/g; s/'$MORT_DEV'/'$MORT_TEST'/g;
                 s/'$PRC_DEV'/'$PRC_TEST'/g; s/'$KERB_LOCAL'/'$KERB_TEST'/g'
}

change_docker_links() {
  
   echo "--- CHANGE STAGE IN DOCKER FILES ---"
   grep -P -R -l -w "$MORT_LOCAL|$PRC_LOCAL" $PROJECTS_DIR |
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

