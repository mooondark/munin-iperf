# munin-iperf
Use this script for monitoring bandwith with iperf3 & munin.

Set a crontab for iperf_munin.sh every 30 mn :
7,37 * * * *    /usr/bin/iperf_munin.sh > /dev/null 2>&1

![day_exemple screenshot](screenshot/iperf-day.png)

Share & enjoy
