ips=$(cat /var/log/auth.log | grep "Forgot password" | awk '{print $11}')
dates=$(cat /var/log/auth.log | grep "Forgot password" | awk '{print $4}') # change column number to date from auth.log

all_ips=()
for ip in $ips; do
    all_ips+=($ip)
done

all_dates=()
for date in $dates; do
    all_dates+=($date)
done

countries=()
for ip in $dates; do
    country=$(whois $(curl ifconfig.me) | grep -iE ^country | awk '{print $2}')
    countries+=($country)
done    

for ip in ${!countries[*]}; do
    echo "${all_ips[ip]}  ${countries[ip]} ${all_dates[ip]}" >> /var/webserver_monitor/unauthorized.log
done
