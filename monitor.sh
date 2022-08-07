#!/bin/bash
old=$(head -1 /var/webserver_monitor/count.txt)
latest=$(wc -l < /var/webserver_monitor/unauthorized.log)
lines=$(($latest - $old))
if ((lines>0));
then
  tail -n $lines /var/webserver_monitor/unauthorized.log | mail -s "New entries" testwestchester3@gmail.com 
else
  echo "No unauthorized access" | mail -s "No unauthorized access" testwestchester3@gmail.com
fi
$lines > /var/webserver_monitor/count.txt 
