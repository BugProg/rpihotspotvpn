sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install dnsmasq hostapd -y
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd
sudo apt-get install openssl
sudo apt-get install npm
sudo npm install body-parser mongoose bcryptjs express jsonwebtoken -y
#install requierements

echo 'static ip_address=192.168.4.1/24' >> /etc/dhcpcd.conf
echo 'nohook wpa_supplicant' >> /etc/dhcpcd.conf
#define static ip

sudo service dhcpcd restart

sudo openssl req -nodes -new -x509 -keyout server.key -out server.cert -subj "/C=FR/ST=./L=./O=./CN=." #create ssl files 


sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig #config dnsmasq
sudo cp ./files/dnsmasq.conf /etc/ 


sudo systemctl start dnsmasq
sudo systemctl reload dnsmasq

sudo cp ./files/hostapd.conf /etc/hostapd/hostapd.conf #set the new conf file of hostapd



sudo sed -i -e "s/#DAEMON_CONF/DAEMON_CONF=\"\/etc\/hostapd\/hostapd.conf\"/g" /etc/default/hostapd #uncommentif and defining conf file


sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd


sudo sed -i -e "s/#net.ipv4.ip_forward=1/#net.ipv4.ip_forward=1/g" /etc/sysctl.conf #setting ipv4 forward


sudo iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat" #save iptable 


sudo sed -i -e "s/exit 0//g" /etc/rc.local #define the iptable restore
echo 'iptables-restore < /etc/iptables.ipv4.nat' >> /etc/rc.local
echo 'exit 0' >> /etc/rc.local
#https://www.raspberrypi.org/documentation/configuration/wireless/access-point.md
echo -n "Reboot Rpi now (y/n) - Reboot it yourself to make it work if No "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    sudo reboot
else
    echo Ok.
fi