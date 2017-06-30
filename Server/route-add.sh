#EDIT: sudo route add -host *URL ot the DB Server*

#!/bin/bash
 
sudo route add default dev tunVPN
sudo route add -host *URL ot the DB Server* dev eth0
sudo route add -host *linux update server of your distro* dev eth0
sudo route add -host resolver1.opendns.com dev tunVPN
sudo route add -host resolver3.opendns.com dev eth0
sudo route add -host www.whatismyip.com tunVPN
