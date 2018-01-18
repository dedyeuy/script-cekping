tgl=$(date +'%Y-%m-%d')
HOSTS="192.168.100.163 192.168.100.167 192.168.100.168 192.168.100.169 192.168.100.170"

COUNT=4

for myHost in $HOSTS
do
  count=$(ssh root@sud-fe01 "ping -c $COUNT $myHost" | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
  if [ $count -eq 0 ]; then
    # 100% failed
    echo "Host : $myHost is down (ping failed) at $(date)" > /tmp/test2.txt
    mail -s "Server Down - $tgl" vorangers@google.com < /tmp/test2.txt
  fi

done

