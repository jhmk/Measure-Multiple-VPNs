#!/bin/bash
 
# select Speedtest Server DEFINE COUNTRY OR CITY!!!
CITY="Sydney" 
 
SLS=$(speedtest --list | grep $CITY | grep -Eo '[0-9]{1,4}' | head -1)
 
# do speedtest and collect datasudo
 
sudo speedtest --server $SLS --csv --timeout 30 > /home/ubuntu/speedtest-csv-full.txt
 
 
# remove content that trigger error
 
awk -F 2017 '{ print $2 }' /home/ubuntu/speedtest-csv-full.txt > /home/ubuntu/peedtest-csv.txt
 
# get response time aka ping
 
RESPONSE=$(awk -F, '{ print $3 }' /home/ubuntu/speedtest-csv.txt)
 
# get response timestamp
 
#TIMESTAMP=$(awk -F, '{ print $4 }' /home/ubuntu/speedtest-csv.txt)
 
# fix for "City, Country" is replacing DATE
 
TSX=$(awk -F 2017 '{ print $1 }' /home/ubuntu/speedtest-csv.txt | awk -F, '{ print $1 }')
 
YEAR="2017"
 
TIMESTAMP="$YEAR$TSX"
 
#echo $TIMESTAMP
 
# get response download
 
DOWNLOAD=$(awk -F, '{ print $4 }' /home/ubuntu/speedtest-csv.txt)
 
# get response upload
 
UPLOAD=$(awk -F, '{ print $5 }' /home/ubuntu/speedtest-csv.txt)
 
# get VPN IP
 
VPNIP=$(curl ident.me --max-time 30)
 
# proxyname
 
PROXYNAME="*url of your server*"
 
# vpn connected
 
VPNIPTEST=$(dig +short myip.opendns.com @resolver1.opendns.com)
 
if [ $VPNIPTEST = *your IP* ]; then
 
    VPNON="NO"
 
        else
 
    VPNON="YES"
 
fi
 
# upload to MySQL DB
 
echo "INSERT INTO vpnstatsau (RESPONSE,TIMESTAMP,DOWNLOAD,UPLOAD,VPNIP,PROXYNAME,VPNON) VALUES ('$RESPONSE','$TIMESTAMP','$DOWNLOAD','$UPLOAD','$VPNIP','$PROXYNAME','$VPNON');" | mysql -u*USER* -p*PASSWORD* *DBNAME* -h *IP*;
 
# empty results
 
sudo truncate -s 0 /home/ubuntu/speedtest-csv.txt
 
sudo truncate -s 0 /home/ubuntu/speedtest-csv-full.txt
