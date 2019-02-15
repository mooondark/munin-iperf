#!/bin/bash

#Download speed for 10s with 4 parallels downstream in ipv4
#Ajust the -f 12 option of cut for your version of iperf3 (sometimes it's more or less)

        down=`iperf3 -f m -c bouygues.iperf.fr -p 5205 -4 -R -P4 -t 10\
                | grep Mbits \
                | cut -d ' ' -f 12 \
                | sed '{$!d;}'`
        echo "down.value $down" > /etc/munin/iperf.down

#Upload speed for 10s with 3 parallels updtream in ipv4 an omitting the first 2 seconds (-O 2)
#Ajust the -f 12 option of cut for your version of iperf3 (sometimes it's more or less)

        up=`iperf3 -f m -c bouygues.iperf.fr -p 5205 -4 -P3 -O 2 -t 10\
                | grep Mbits \
                | cut -d ' ' -f 13 \
                | sed '{$!d;}'`
        echo "up.value $up" > /etc/munin/iperf.up
