sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt install dnsmasq hostapd -y
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd

if command -v python &>/dev/null; then
    echo Python 3 is installed
else
    sudo apt-get install python3.6 -y
fi

sudo npm install body-parser mongoose bcryptjs express jsonwebtoken -y

'''sudo nano /etc/dhcpcd.conf
Go to the end of the file and edit it so that it looks like the following:
interface wlan0
    static ip_address=192.168.4.1/24
    nohook wpa_supplicant
Now restart the dhcpcd daemon and set up the new wlan0 configuration:
'''

echo static ip_address=192.168.4.1/24 >> /etc/dhcpcd.conf
echo nohook wpa_supplicant >> /etc/dhcpcd.conf

sudo service dhcpcd restart

//openssl


sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo install.py dnsmasq -copier coller fichier


sudo systemctl start dnsmasq
sudo systemctl reload dnsmasq

sudo install.py hostapdconf - copier coller .conf



sed -i -e "s/#DAEMON_CONF/DAEMON_CONF=\"\/etc\/hostapd\/hostapd.conf\"/g" /etc/default/hostapd


sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd


sed -i -e "s/#net.ipv4.ip_forward=1/#net.ipv4.ip_forward=1/g" /etc/sysctl.conf


sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"


sed -i -e "s/exit 0//g" /etc/rc.local
echo 'iptables-restore < /etc/iptables.ipv4.nat' >> /etc/rc.local
echo 'exit 0' >> /etc/rc.local
#https://www.raspberrypi.org/documentation/configuration/wireless/access-point.md
