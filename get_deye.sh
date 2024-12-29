#!/bin/bash

MYDIR=$(pwd)
FHEM_CUR=Balkonkraftwerk_cur
FHEM_DAY=Balkonkraftwerk_day
FHEM_TOT=Balkonkraftwerk_tot

if [ $# -ne 3 ]; then
  echo "Usage:"
  echo $0 " <IP Adresse Deye Inverter> <Username> <Password>"
  exit
fi

date "+-----%Y.%m.%d %H:%M-----"
curl -u "$2:$3" http://$1/status.html > /tmp/deye.txt

if [ $? -eq 0 ]; then
  POWAKT=$(cat /tmp/deye.txt | grep "webdata_now_p =" | cut -d = -f 2 | tr ";" " "| tr "\"" " ")
  POWDAY=$(cat /tmp/deye.txt | grep "webdata_today_e =" | cut -d = -f 2 | tr ";" " "| tr "\"" " ")
  POWTOT=$(cat /tmp/deye.txt | grep "webdata_total_e =" | cut -d = -f 2 | tr ";" " "| tr "\"" " ")

  echo "Aktuelle Leistung:" ${POWAKT}
  echo "Tagesleistung:    " ${POWDAY}
  echo "Gesamtleistung:   " ${POWTOT}

  ${MYDIR}/tn_fhem.php ${FHEM_CUR} ${POWAKT}

  if [ ${POWDAY} -gt 0 ]; then
    ${MYDIR}/tn_fhem.php ${FHEM_DAY} ${POWDAY}
  fi

  if [ ${POWTOT} -gt 0 ]; then
    ${MYDIR}/tn_fhem.php ${FHEM_TOT} ${POWTOT}
  fi

else
  echo "Deye offline"
fi

