



1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP

При использовании первой команды с учетом маски, публичный маршрутизатор указывает на ошибку

route-views>show ip route 5.16.126.49/22
                                     ^
% Invalid input detected at '^' marker.

route-views>

без маски все ок:

route-views>show ip route 5.16.126.49
Routing entry for 5.16.124.0/22
  Known via "bgp 6447", distance 20, metric 0
  Tag 6939, type external
  Last update from 64.71.137.241 7w0d ago
  Routing Descriptor Blocks:
  * 64.71.137.241, from 64.71.137.241, 7w0d ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 6939
      MPLS label: none

При использовании BGP вывод следующий

route-views>show bgp route 5.16.126.49/22
% Ambiguous command:  "show bgp route 5.16.126.49/22"
route-views>show bgp 5.16.126.49/22       
BGP routing table entry for 5.16.124.0/22, version 311625075
Paths: (24 available, best #19, table default)
  Not advertised to any peer
  Refresh Epoch 1
  8283 1299 9049 51570
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin incomplete, metric 0, localpref 100, valid, external
      Community: 1299:30000 8283:1 8283:101
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001 
      path 7FE0A7D5B868 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 14315 174 1299 9049 51570
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin incomplete, localpref 100, valid, external
      Community: 14315:5000 53767:5000
      path 7FE0FF20ACD0 RPKI State not found
      rx pathid: 0, tx pathid: 0


2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

root@ubuntu:~# ip link add dummy0 type dummy
root@ubuntu:~# sudo ip addr add 10.0.19.0/22 dev dummy0
root@ubuntu:~# sudo ip link set dummy0 up
root@ubuntu:~# sudo ip addr add 10.0.29.0/24 dev eth10
root@ubuntu:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 00:0c:29:ec:77:f9 brd ff:ff:ff:ff:ff:ff
    altname enp2s1
    inet 192.168.157.129/24 brd 192.168.157.255 scope global dynamic noprefixroute ens33
       valid_lft 1757sec preferred_lft 1757sec
    inet6 fe80::415a:9304:7614:782b/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: eth10: <BROADCAST,NOARP,SLAVE> mtu 1500 qdisc noqueue master bond0 state DOWN group default qlen 1000
    link/ether 8a:90:b7:ee:99:ba brd ff:ff:ff:ff:ff:ff
    inet 10.0.29.0/24 scope global eth10
       valid_lft forever preferred_lft forever
4: eth9: <BROADCAST,NOARP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
    link/ether 8a:90:b7:ee:99:ba brd ff:ff:ff:ff:ff:ff
5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 8a:90:b7:ee:99:ba brd ff:ff:ff:ff:ff:ff
6: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether 9a:14:4a:84:59:73 brd ff:ff:ff:ff:ff:ff
    inet 10.0.19.0/22 scope global dummy0
       valid_lft forever preferred_lft forever
    inet6 fe80::9814:4aff:fe84:5973/64 scope link 
       valid_lft forever preferred_lft forever

root@ubuntu:~# ip route add 8.8.8.0/22 via 10.0.29.0
root@ubuntu:~# ip route add 8.8.8.0/24 via 10.0.29.0
root@ubuntu:~# ip route
default via 192.168.157.2 dev ens33 proto dhcp metric 100 
8.8.8.0/24 via 10.0.29.0 dev dummy0 
8.8.8.0/22 via 10.0.19.0 dev dummy0 
10.0.16.0/22 dev dummy0 proto kernel scope link src 10.0.19.0 
10.0.29.0/24 dev dummy0 proto kernel scope link src 10.0.29.0 
169.254.0.0/16 dev ens33 scope link metric 1000 
192.168.157.0/24 dev ens33 proto kernel scope link src 192.168.157.129 metric 100 



3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

alegach@ubuntu:~$ ss -tpan
State     Recv-Q Send-Q          Local Address:Port          Peer Address:Port  Process                                                                         
LISTEN    0      4096            127.0.0.53%lo:53                 0.0.0.0:*                                                                                     
LISTEN    0      5                   127.0.0.1:631                0.0.0.0:*                                                                                     
LISTEN    0      4096                127.0.0.1:8125               0.0.0.0:*                                                                                     
LISTEN    0      4096                  0.0.0.0:19999              0.0.0.0:*                                                                                     
ESTAB     0      0             192.168.157.129:45664       188.114.99.165:443    users:(("firefox",pid=3341,fd=51))                                             
ESTAB     0      0             192.168.157.129:40204          3.68.63.139:443    users:(("slack",pid=11958,fd=27))                                              
TIME-WAIT 0      0       192.168.157.129%ens33:46096        35.232.111.17:80                                                                                    
ESTAB     0      0             192.168.157.129:57696       54.148.154.169:443    users:(("firefox",pid=3341,fd=97))                                             
ESTAB     0      0             192.168.157.129:57842          3.68.175.98:443    users:(("slack",pid=11958,fd=30))                                              
ESTAB     0      0                   127.0.0.1:60292            127.0.0.1:80                                                                                    
TIME-WAIT 0      0             192.168.157.129:46332       34.117.237.239:443                                                                                   
ESTAB     0      0             192.168.157.129:50554        140.82.113.26:443    users:(("firefox",pid=3341,fd=44))                                             
ESTAB     0      0             192.168.157.129:56332       198.252.206.25:443    users:(("firefox",pid=3341,fd=128))                                            
ESTAB     0      0             192.168.157.129:53412       104.16.249.249:443    users:(("firefox",pid=3341,fd=36))                                             
LISTEN    0      5                       [::1]:631                   [::]:*                                                                                     
LISTEN    0      4096                        *:9100                     *:*                                                                                     
LISTEN    0      511                         *:80                       *:*                                                                                     
ESTAB     0      0          [::ffff:127.0.0.1]:80      [::ffff:127.0.0.1]:60292   

4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

alegach@ubuntu:~$ ss -upan
State                 Recv-Q                 Send-Q                                         Local Address:Port                                     Peer Address:Port                Process                
UNCONN                0                      0                                                  127.0.0.1:8125                                          0.0.0.0:*                                          
UNCONN                0                      0                                              127.0.0.53%lo:53                                            0.0.0.0:*                                          
ESTAB                 0                      0                                      192.168.157.129%ens33:68                                    192.168.157.254:67                                         
UNCONN                0                      0                                                    0.0.0.0:631                                           0.0.0.0:*                                          
UNCONN                0                      0                                                    0.0.0.0:5353                                          0.0.0.0:*                                          
UNCONN                0                      0                                                    0.0.0.0:56961                                         0.0.0.0:*                                          
UNCONN                0                      0                                                       [::]:58421                                            [::]:*                                          
UNCONN                0                      0                                                       [::]:5353                                             [::]:*                                          
alegach@ubuntu:~$ 


5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.


https://drive.google.com/file/d/1zYKOYmBxbKauGTX8Tor1y5UwZ3DNRSEg/view?usp=sharing







