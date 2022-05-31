Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2


1.  Проверьте список доступных сетевых интерфейсов на вашем компьютере. Какие команды есть для этого в Linux и в Windows?

For Windows:

C:\Users\Alexandr>ipconfig /all

Настройка протокола IP для Windows

   Имя компьютера  . . . . . . . . . : HOME-PC
   Основной DNS-суффикс  . . . . . . :
   Тип узла. . . . . . . . . . . . . : Гибридный
   IP-маршрутизация включена . . . . : Нет
   WINS-прокси включен . . . . . . . : Нет

Адаптер Ethernet Ethernet:

   Состояние среды. . . . . . . . : Среда передачи недоступна.
   DNS-суффикс подключения . . . . . :
   Описание. . . . . . . . . . . . . : Intel(R) Ethernet Connection (7) I219-V
   Физический адрес. . . . . . . . . : 00-D8-61-D9-65-C6
   DHCP включен. . . . . . . . . . . : Да
   Автонастройка включена. . . . . . : Да

Адаптер беспроводной локальной сети Подключение по локальной сети* 1:

   Состояние среды. . . . . . . . : Среда передачи недоступна.
   DNS-суффикс подключения . . . . . :
   Описание. . . . . . . . . . . . . : Microsoft Wi-Fi Direct Virtual Adapter
   Физический адрес. . . . . . . . . : 06-D9-F5-8B-F6-FB
   DHCP включен. . . . . . . . . . . : Да
   Автонастройка включена. . . . . . : Да

Адаптер беспроводной локальной сети Подключение по локальной сети* 10:

   Состояние среды. . . . . . . . : Среда передачи недоступна.
   DNS-суффикс подключения . . . . . :
   Описание. . . . . . . . . . . . . : Microsoft Wi-Fi Direct Virtual Adapter #2
   Физический адрес. . . . . . . . . : 06-D9-F5-8B-FE-FB
   DHCP включен. . . . . . . . . . . : Нет
   Автонастройка включена. . . . . . : Да

Адаптер Ethernet VMware Network Adapter VMnet1:

   DNS-суффикс подключения . . . . . :
   Описание. . . . . . . . . . . . . : VMware Virtual Ethernet Adapter for VMnet1
   Физический адрес. . . . . . . . . : 00-50-56-C0-00-01
   DHCP включен. . . . . . . . . . . : Нет
   Автонастройка включена. . . . . . : Да
   Локальный IPv6-адрес канала . . . : fe80::4dde:ce0c:f566:23c2%21(Основной)
   IPv4-адрес. . . . . . . . . . . . : 192.168.59.1(Основной)
   Маска подсети . . . . . . . . . . : 255.255.255.0
   Основной шлюз. . . . . . . . . :
   IAID DHCPv6 . . . . . . . . . . . : 100683862
   DUID клиента DHCPv6 . . . . . . . : 00-01-00-01-28-C5-85-FD-00-D8-61-D9-65-C6
   DNS-серверы. . . . . . . . . . . : fec0:0:0:ffff::1%1
                                       fec0:0:0:ffff::2%1
                                       fec0:0:0:ffff::3%1
   NetBios через TCP/IP. . . . . . . . : Включен

Адаптер Ethernet VMware Network Adapter VMnet8:

   DNS-суффикс подключения . . . . . :
   Описание. . . . . . . . . . . . . : VMware Virtual Ethernet Adapter for VMnet8
   Физический адрес. . . . . . . . . : 00-50-56-C0-00-08
   DHCP включен. . . . . . . . . . . : Нет
   Автонастройка включена. . . . . . : Да
   Локальный IPv6-адрес канала . . . : fe80::15fb:449b:75e8:252%6(Основной)
   IPv4-адрес. . . . . . . . . . . . : 192.168.157.1(Основной)
   Маска подсети . . . . . . . . . . : 255.255.255.0
   Основной шлюз. . . . . . . . . :
   IAID DHCPv6 . . . . . . . . . . . : 134238294
   DUID клиента DHCPv6 . . . . . . . : 00-01-00-01-28-C5-85-FD-00-D8-61-D9-65-C6
   DNS-серверы. . . . . . . . . . . : fec0:0:0:ffff::1%1
                                       fec0:0:0:ffff::2%1
                                       fec0:0:0:ffff::3%1
   NetBios через TCP/IP. . . . . . . . : Включен

Адаптер беспроводной локальной сети Беспроводная сеть:

   DNS-суффикс подключения . . . . . :
   Описание. . . . . . . . . . . . . : ASUS PCE-AC68 802.11ac Network Adapter
   Физический адрес. . . . . . . . . : 04-D9-F5-8B-F6-FB
   DHCP включен. . . . . . . . . . . : Да
   Автонастройка включена. . . . . . : Да
   Локальный IPv6-адрес канала . . . : fe80::91e7:eeaf:42e:3875%8(Основной)
   IPv4-адрес. . . . . . . . . . . . : 192.168.50.181(Основной)
   Маска подсети . . . . . . . . . . : 255.255.255.0
   Аренда получена. . . . . . . . . . : 27 мая 2022 г. 22:53:39
   Срок аренды истекает. . . . . . . . . . : 1 июня 2022 г. 22:08:35
   Основной шлюз. . . . . . . . . : 192.168.50.1
   DHCP-сервер. . . . . . . . . . . : 192.168.50.1
   IAID DHCPv6 . . . . . . . . . . . : 168090101
   DUID клиента DHCPv6 . . . . . . . : 00-01-00-01-28-C5-85-FD-00-D8-61-D9-65-C6
   DNS-серверы. . . . . . . . . . . : 192.168.50.1
   NetBios через TCP/IP. . . . . . . . : Включен

Адаптер Ethernet Сетевое подключение Bluetooth:

   Состояние среды. . . . . . . . : Среда передачи недоступна.
   DNS-суффикс подключения . . . . . :
   Описание. . . . . . . . . . . . . : Bluetooth Device (Personal Area Network)
   Физический адрес. . . . . . . . . : E8-48-B8-C8-20-00
   DHCP включен. . . . . . . . . . . : Да
   Автонастройка включена. . . . . . : Да


Для Linux можно использовать либо ifconfig, либо  ip a

alegach@ubuntu:~$ ifconfig
ens33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.157.129  netmask 255.255.255.0  broadcast 192.168.157.255
        inet6 fe80::415a:9304:7614:782b  prefixlen 64  scopeid 0x20<link>
        ether 00:0c:29:ec:77:f9  txqueuelen 1000  (Ethernet)
        RX packets 428927  bytes 341594023 (341.5 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 280585  bytes 55351206 (55.3 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 89920  bytes 27104471 (27.1 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 89920  bytes 27104471 (27.1 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0



----------------
alegach@ubuntu:~$ ip a
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
       valid_lft 1386sec preferred_lft 1386sec
    inet6 fe80::415a:9304:7614:782b/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever


2.  Какой протокол используется для распознавания соседа по сетевому интерфейсу? Какой пакет и команды есть в Linux для этого?

Нужно использовать пакет lldpd + команда llpdctl, которая позволяет посмотреть соседей.

When invoked as lldpctl, lldpcli will display detailed information about each neighbors on the specified interfaces or on all interfaces if none are specified.

3.  Какая технология используется для разделения L2 коммутатора на несколько виртуальных сетей? Какой пакет и команды есть в Linux для этого? Приведите пример конфига.

Разделение на несколько виртуальных сетей выполняется с помощью технологии VLAN.

По командам я подключил модуль ядра Dummy, подцепил к нему виртуальный Ethernet интерфейс и назначин ему IP-адрес+маску

alegach@ubuntu:~$ sudo modprobe dummy
alegach@ubuntu:~$ sudo lsmod | grep dummy
dummy                  16384  0
alegach@ubuntu:~$ sudo ip link add eth10 type dummy

alegach@ubuntu:~$ ip a
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
       valid_lft 1277sec preferred_lft 1277sec
    inet6 fe80::415a:9304:7614:782b/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: eth10: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether fe:02:2c:cc:f0:b7 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.3/12 scope global eth10
       valid_lft forever preferred_lft forever

alegach@ubuntu:~$ sudo ip addr add 10.0.0.3/12 dev eth10
alegach@ubuntu:~$ ip a
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
       valid_lft 1277sec preferred_lft 1277sec
    inet6 fe80::415a:9304:7614:782b/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: eth10: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether fe:02:2c:cc:f0:b7 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.3/12 scope global eth10
       valid_lft forever preferred_lft forever


4.  Какие типы агрегации интерфейсов есть в Linux? Какие опции есть для балансировки нагрузки? Приведите пример конфига.

Типы агрегации интерфейсов в Linux:

Mode-0(balance-rr) – Данный режим используется по умолчанию. Balance-rr обеспечивается балансировку нагрузки и отказоустойчивость. В данном режиме сетевые пакеты отправляются “по кругу”, от первого интерфейса к последнему

Mode-1(active-backup) – Один из интерфейсов работает в активном режиме, остальные в ожидающем. При обнаружении проблемы на активном интерфейсе производится переключение на ожидающий интерфейс. Не требуется поддержки от коммутатора. 

Mode-2(balance-xor) – Передача пакетов распределяется по типу входящего и исходящего трафика по формуле ((MAC src) XOR (MAC dest)) % число интерфейсов. Режим дает балансировку нагрузки и отказоустойчивость. Не требуется дополнительной настройки коммутатора/коммутаторов.

Mode-3(broadcast) – Происходит передача во все объединенные интерфейсы, тем самым обеспечивая отказоустойчивость. Рекомендуется только для использования MULTICAST трафика.

Mode-4(802.3ad) – динамическое объединение одинаковых портов. В данном режиме можно значительно увеличить пропускную способность входящего так и исходящего трафика. Для данного режима необходима поддержка и настройка коммутатора/коммутаторов.

Mode-5(balance-tlb) – Адаптивная балансировки нагрузки трафика. Входящий трафик получается только активным интерфейсом, исходящий распределяется в зависимости от текущей загрузки канала каждого интерфейса. Не требуется специальной поддержки и настройки коммутатора/коммутаторов.

Mode-6(balance-alb) – Адаптивная балансировка нагрузки. Отличается более совершенным алгоритмом балансировки нагрузки чем Mode-5). Обеспечивается балансировку нагрузки как исходящего так и входящего трафика. Не требуется специальной поддержки и настройки коммутатора/коммутаторов. 


Для балансировки нагрузки можно использовать отдельные балансировщики, такие как Nginx, HAProxy и Keepalive, либо можно использовать bonding предварительно установив его пакет.

Ниже создал бонд, добавил еще один интерфейс eth9 для последующего объединения и объединил его в bond0

alegach@ubuntu:~$ sudo ip link add eth9 type dummy
alegach@ubuntu:~$ ip a
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
       valid_lft 1121sec preferred_lft 1121sec
    inet6 fe80::415a:9304:7614:782b/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: eth10: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether fe:02:2c:cc:f0:b7 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.3/12 scope global eth10
       valid_lft forever preferred_lft forever
4: eth9: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 8a:90:b7:ee:99:ba brd ff:ff:ff:ff:ff:ff

alegach@ubuntu:~$ sudo ip addr add 10.0.0.4/12 dev eth9
alegach@ubuntu:~$ sudo modprobe bonding
alegach@ubuntu:~$ sudo ip link add bond0 type bond mode 802.3ad
alegach@ubuntu:~$ ifenslave bond0 eth9 eth10
RTNETLINK answers: Operation not permitted
alegach@ubuntu:~$ sudo ifenslave bond0 eth9 eth10
alegach@ubuntu:~$ ifenslave --all-interfaces
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 00:0c:29:ec:77:f9 brd ff:ff:ff:ff:ff:ff
    altname enp2s1
3: eth10: <BROADCAST,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 8a:90:b7:ee:99:ba brd ff:ff:ff:ff:ff:ff
4: eth9: <BROADCAST,NOARP,SLAVE,UP,LOWER_UP> mtu 1500 qdisc noqueue master bond0 state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether 8a:90:b7:ee:99:ba brd ff:ff:ff:ff:ff:ff
5: bond0: <BROADCAST,MULTICAST,MASTER> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 8a:90:b7:ee:99:ba brd ff:ff:ff:ff:ff:ff


5.  Сколько IP адресов в сети с маской /29 ? Сколько /29 подсетей можно получить из сети с маской /24. Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.

Исходя из калькулятора, для маски/29 всего предоставлено 8 IP-адресов, 6 из которых остаются под доп. хосты

alegach@ubuntu:~$ ipcalc 10.10.10.0/29
Address:   10.10.10.0           00001010.00001010.00001010.00000 000
Netmask:   255.255.255.248 = 29 11111111.11111111.11111111.11111 000
Wildcard:  0.0.0.7              00000000.00000000.00000000.00000 111
=>
Network:   10.10.10.0/29        00001010.00001010.00001010.00000 000
HostMin:   10.10.10.1           00001010.00001010.00001010.00000 001
HostMax:   10.10.10.6           00001010.00001010.00001010.00000 110
Broadcast: 10.10.10.7           00001010.00001010.00001010.00000 111
Hosts/Net: 6                     Class A, Private Internet


Для маски /24 предоставлено 256 адресов

alegach@ubuntu:~$ ipcalc 10.10.10.0/24
Address:   10.10.10.0           00001010.00001010.00001010. 00000000
Netmask:   255.255.255.0 = 24   11111111.11111111.11111111. 00000000
Wildcard:  0.0.0.255            00000000.00000000.00000000. 11111111
=>
Network:   10.10.10.0/24        00001010.00001010.00001010. 00000000
HostMin:   10.10.10.1           00001010.00001010.00001010. 00000001
HostMax:   10.10.10.254         00001010.00001010.00001010. 11111110
Broadcast: 10.10.10.255         00001010.00001010.00001010. 11111111
Hosts/Net: 254                   Class A, Private Internet

Из подсети 10.10.10.0/24 можно получить 8 подсетей 10.10.10.0/29 
Подсети будут начинаться с 10.10.10.0/29, добавляя по 8 к последнему сегменту (10.10.10.8/29), вплоть до адреса 10.10.10.248.29. До еще одной подсети не хватает двух адресов, зарезервированных под броадкаст и подсеть.


6.  Задача: вас попросили организовать стык между 2-мя организациями. Диапазоны 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 уже заняты. Из какой подсети допустимо взять частные IP адреса? Маску выберите из расчета максимум 40-50 хостов внутри подсети.

Можно использовать оставшийся диапазон = 100.64.0.0 — 100.127.255.255 (маска подсети 255.192.0.0 или /10)
Из расчета калькулятора для 45 хостов лучше использовать маску /26.


alegach@ubuntu:~$ ipcalc 100.64.0.0/10 -s 45
Address:   100.64.0.0           01100100.01 000000.00000000.00000000
Netmask:   255.192.0.0 = 10     11111111.11 000000.00000000.00000000
Wildcard:  0.63.255.255         00000000.00 111111.11111111.11111111
=>
Network:   100.64.0.0/10        01100100.01 000000.00000000.00000000
HostMin:   100.64.0.1           01100100.01 000000.00000000.00000001
HostMax:   100.127.255.254      01100100.01 111111.11111111.11111110
Broadcast: 100.127.255.255      01100100.01 111111.11111111.11111111
Hosts/Net: 4194302               Class A

1. Requested size: 45 hosts
Netmask:   255.255.255.192 = 26 11111111.11111111.11111111.11 000000
Network:   100.64.0.0/26        01100100.01000000.00000000.00 000000
HostMin:   100.64.0.1           01100100.01000000.00000000.00 000001
HostMax:   100.64.0.62          01100100.01000000.00000000.00 111110
Broadcast: 100.64.0.63          01100100.01000000.00000000.00 111111
Hosts/Net: 62                    Class A

Needed size:  64 addresses.
Used network: 100.64.0.0/26
Unused:
100.64.0.64/26
100.64.0.128/25
100.64.1.0/24
100.64.2.0/23
100.64.4.0/22
100.64.8.0/21
100.64.16.0/20
100.64.32.0/19
100.64.64.0/18
100.64.128.0/17
100.65.0.0/16
100.66.0.0/15
100.68.0.0/14
100.72.0.0/13
100.80.0.0/12
100.96.0.0/11




7.  Как проверить ARP таблицу в Linux, Windows? Как очистить ARP кеш полностью? Как из ARP таблицы удалить только один нужный IP?

Для Windows:

C:\Users\Alexandr>arp -a

Интерфейс: 192.168.157.1 --- 0x6
  адрес в Интернете      Физический адрес      Тип
  192.168.157.255       ff-ff-ff-ff-ff-ff     статический
  224.0.0.22            01-00-5e-00-00-16     статический
  224.0.0.251           01-00-5e-00-00-fb     статический
  224.0.0.252           01-00-5e-00-00-fc     статический
  239.255.255.250       01-00-5e-7f-ff-fa     статический

Интерфейс: 192.168.50.181 --- 0x8
  адрес в Интернете      Физический адрес      Тип
  192.168.50.1          04-d9-f5-ef-ad-20     динамический
  192.168.50.255        ff-ff-ff-ff-ff-ff     статический
  224.0.0.22            01-00-5e-00-00-16     статический
  224.0.0.251           01-00-5e-00-00-fb     статический
  224.0.0.252           01-00-5e-00-00-fc     статический
  239.255.255.250       01-00-5e-7f-ff-fa     статический
  255.255.255.255       ff-ff-ff-ff-ff-ff     статический

Интерфейс: 192.168.59.1 --- 0x15
  адрес в Интернете      Физический адрес      Тип
  192.168.59.255        ff-ff-ff-ff-ff-ff     статический
  224.0.0.22            01-00-5e-00-00-16     статический
  224.0.0.251           01-00-5e-00-00-fb     статический
  224.0.0.252           01-00-5e-00-00-fc     статический
  239.255.255.250       01-00-5e-7f-ff-fa     статический

Чтобы очистить ARP-кэш, необходимо выполнить команду: netsh interface ip delete arpcache

Для Linux:

alegach@ubuntu:~$ arp
Address                  HWtype  HWaddress           Flags Mask            Iface
192.168.157.254          ether   00:50:56:eb:10:3c   C                     ens33
_gateway                 ether   00:50:56:e9:86:97   C                     ens33


Удалить все записи можно с помощью команды ip neigh flush all
Удалить конкретно одну запись можно с помощью  ip neigh del dev {Имя интерфейса} {IP-адрес}


