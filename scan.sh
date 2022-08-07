#!/bin/bash
ips=$(sudo cat /var/log/auth.log | grep "Invalid user" | awk '{print $10}')
months=$(sudo cat /var/log/auth.log | grep "Invalid user" | awk '{print $1}')
days=$(sudo cat /var/log/auth.log | grep "Invalid user" | awk '{print $2}')
list_ips=()
list_months=()
list_days=()
list_countries=()
for ip in $ips; do
    list_ips+=($ip)
done
for date in $months; do
    list_months+=($date)
done
for date in $days; do
    list_days+=($date)
done
for ip in $ips; do
    country=$(curl ipinfo.io/$ip/country)
    countries+=${country}
done    
for ip in ${!countries[*]}; do
    echo "${list_ips[ip]}  ${countries[ip]} ${list_months[ip]} ${list_days[ip]}" >> /var/webserver_log/unauthorized.log
done
