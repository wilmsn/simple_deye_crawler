#!/bin/bash

cd dirname $0

MYDIR=$(cd `dirname $0` && pwd)
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
  POWTOTNUM=$(cat /tmp/deye.txt | grep "webdata_total_e =" | cut -d = -f 2 | cut -d . -f 1 | tr ";" " "| tr "\"" " " )

  echo "Aktuelle Leistung:" ${POWAKT}
  echo "Tagesleistung:    " ${POWDAY}
  echo ${POWDAYNUM}
  echo "Gesamtleistung:   " ${POWTOT}
  echo ${POWTOTNUM}

  ${MYDIR}/tn_fhem.php ${FHEM_CUR} ${POWAKT}

  ${MYDIR}/tn_fhem.php ${FHEM_DAY} ${POWDAY}

  if [ "${POWTOTNUM}" -gt 0 ]; then
    ${MYDIR}/tn_fhem.php ${FHEM_TOT} ${POWTOT}
  fi

else
  echo "Deye offline"
fi

