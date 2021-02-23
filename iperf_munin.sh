#!/bin/bash

# Available servers from Bouygues ISP :
# - bouygues.testdebit.info (Paris) : From port 9200 to port 9240
# - lyon.testdebit.info (Lyon) : From port 9200 to port 9240
# - aix-marseille.testdebit.info (Aix) : From port 9200 to port 9240
# - bordeaux.testdebit.info (Bordeaux) : From port 9200 to port 9240
# - lille.testdebit.info (Lille) : From port 9200 to port 9240

sleep $[ ( $RANDOM % 20 ) + 15 ]s

#Ajust the -f 12 option of cut for your version of iperf3 (sometimes it's more or less)

        down=`iperf3 -f m -c lyon.testdebit.info -p 9217 -6 -R -P8 -O 2 -t 8\
                | grep Mbits \
                | cut -d ' ' -f 12 \
                | sed '{$!d;}'`
        echo "down.value $down" > /etc/munin/iperf.down
        
#No update if server is busy
        if [ "$down" = "" ]
        then
          exit
        else
          echo "down.value $down" > /etc/munin/iperf.down
        fi

#Upload speed for 10s with 4 parallels updtream in ipv4 an omitting the first 2 seconds (-O 2)
#Ajust the -f 12 option of cut for your version of iperf3 (sometimes it's more or less)

        up=`iperf3 -f m -c lyon.testdebit.info -p 9219 -6 -P4 -O 2 -t 10\
                | grep Mbits \
                | cut -d ' ' -f 13 \
                | sed '{$!d;}'`
        echo "up.value $up" > /etc/munin/iperf.up
        
#No update if server is busy
        if [ "$up" = ""  ]
        then
          exit
        else
          echo "up.value $up" > /etc/munin/iperf.up
        fi
