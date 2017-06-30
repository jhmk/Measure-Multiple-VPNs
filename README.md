# Measure-Multiple-VPNs
Script to use the VPN with the best Performance

Preparement:
- MySQL Database
- min. 2 Linux machines with VPN & Squid Proxy
- min. 2 VPN provider

Infrastructure:

Host -> grab stats from DB wich VPN it should use -> connect to it via Proxy
*needs to be updated*

To Do:
1. install squid and put in the config
2. Add routing table
sudo nano /etc/iproute2/rt_tables
add "1000  vpn"
3. install openvpn
4. edit and run route-add.sh

Collect info about VPN Speed and write to DB:
- install speedtest via pip (pip install speedtest-cli) #as root with sudo -H
- use the IP of your DB and add the IP in route-add.sh

Create Cronjobs:
*/10 * * * * sudo sh /home/ubuntu/check_vpn.sh
*/10 * * * * sh /home/ubuntu/vpn-speedtest.sh
