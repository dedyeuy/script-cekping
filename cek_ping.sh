tgl=$(date +'%Y-%m-%d')
#HOSTS="192.168.100.162 192.168.100.163 192.168.100.164 192.168.100.165 192.168.100.166 192.168.100.167 192.168.100.168 192.168.100.169 192.168.101.170"
HOSTS="192.168.100.162 192.168.100.164 192.168.100.165 192.168.100.166"

COUNT=4

for myHost in $HOSTS
do
  count=$(ping -c $COUNT $myHost | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
  if [ $count -eq 0 ]; then
    # 100% failed
    echo "Host : $myHost is down (ping failed) at $(date)" > /tmp/test.txt
    mail -s "Server Down - $tgl" vorangers@google.com < /tmp/test.txt
  fi

done

