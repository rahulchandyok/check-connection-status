#!/bin/bash

TIME=`/bin/date`
GREP="/bin/grep"
NETSTAT="/bin/netstat"
OPTIONS="-anp"
AWK="/bin/awk"
WC="/usr/bin/wc"
SORT="/bin/sort"
UNIQ="/usr/bin/uniq"
SED="/bin/sed"
CUT="/bin/cut"
PORT=$1
PROGNAME=$0

if [ $# -lt 1 ]
then
        echo "${PROGNAME} PORT"
        echo "Example ${PROGNAME} 80"
        exit 1
fi

CONNCOUNT=`${NETSTAT} ${OPTIONS} | ${GREP} :${PORT} | ${WC} -l`
IPLIST=`${NETSTAT} ${OPTIONS} | ${GREP} :${PORT} | ${AWK} '{print $5}' | ${SED} s/::ffff://g | ${CUT} -d: -f1 | ${SORT} | ${UNIQ} -c | ${SORT} -r`

echo "IP Addresses List with connections:"
echo "${IPLIST}"
echo "Number of connections on port ${PORT} are: ${CONNCOUNT}"connections-status.sh
