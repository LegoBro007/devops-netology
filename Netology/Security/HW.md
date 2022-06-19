Домашнее задание к занятию "3.9. Элементы безопасности информационных систем

1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

Готово, удобно :) 

2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

Тоже сделал, еще удобней :) 

3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

alegach@ubuntu:~/Netology/Security$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \-keyout /etc/ssl/private/apache-selfsigned.key \-out /etc/ssl/certs/apache-selfsigned.crt \-subj "/C=RU/ST=SPB/L=SPB/O=LB/OU=Org/CN=localhost"
[sudo] password for alegach: 
Generating a RSA private key
...+++++
......+++++
writing new private key to '/etc/ssl/private/apache-selfsigned.key'
-----
alegach@ubuntu:~/Netology/Security$ sudo vim /etc/apache2/sites-available/5.16.xxx.xxx.conf
alegach@ubuntu:~/Netology/Security$ sudo mkdir /var/www/5.16.xxx.xxx
alegach@ubuntu:~/Netology/Security$ sudo vim /var/www/5.16.xxx.xxx/index.html
alegach@ubuntu:~/Netology/Security$ sudo a2ensite 5.16.xxx.xxx.conf
Enabling site 5.16.xxx.xxx.
To activate the new configuration, you need to run:
  systemctl reload apache2
alegach@ubuntu:~/Netology/Security$ systemctl reload apache2
alegach@ubuntu:~/Netology/Security$ sudo apache2ctl configtest
Syntax OK

4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

Склонировал скрипт и запустил проверку. Пример результата ниже, копировать все, конечно же, не стал, слишком длинно 

 Testing vulnerabilities 

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
 ROBOT                                     not vulnerable (OK)
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
 BREACH (CVE-2013-3587)                    potentially NOT ok, "br gzip" HTTP compression detected. - only supplied "/" tested
                                           Can be ignored for static pages or if no secrets in the page
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
 TLS_FALLBACK_SCSV (RFC 7507)              Downgrade attack prevention supported (OK)
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    VULNERABLE, uses 64 bit block ciphers
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services, see
                                           https://search.censys.io/search?resource=hosts&virtual_hosts=INCLUDE&q=DDA046512F9E978F995532ED3743690134D3A254D9B12D532FCC9263ADC4F78C
 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
 BEAST (CVE-2011-3389)                     TLS1: ECDHE-ECDSA-AES128-SHA ECDHE-ECDSA-AES256-SHA ECDHE-RSA-AES128-SHA ECDHE-RSA-AES256-SHA AES128-SHA AES256-SHA DES-CBC3-SHA 
                                           VULNERABLE -- but also supports higher protocols  TLSv1.1 TLSv1.2 (likely mitigated)
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.

Решил сделать на примере Github,чтобы потом было юзабельно на практике

alegach@ubuntu:~$ ssh-keygen -t ed25519 -C "sasha-leg@mail.ru"
Generating public/private ed25519 key pair.
\Enter file in which to save the key (/home/alegach/.ssh/id_ed25519): githubkey
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in \githubkey
Your public key has been saved in \githubkey.pub
The key fingerprint is:
SHA256:c0k6PKKGy4sqoe7TBTVG3CyQZABbtDowPGPL8mq7jmk sasha-leg@mail.ru
The key's randomart image is:


alegach@ubuntu:~$ eval "$(ssh-agent -s)"
Agent pid 4069

alegach@ubuntu:~$ ssh-add ~/.ssh/githubkey
Identity added: /home/alegach/.ssh/githubkey (sasha-leg@mail.ru)
alegach@ubuntu:~$ cat ~/.ssh/githubkey.pub
ssh-ed25519 ххххххххххххххххххххххххххххххххххххххххххххххххххххххххххх  sasha-leg@mail.ru
alegach@ubuntu:~$ ssh -T git@github.com
The authenticity of host 'github.com (140.82.121.4)' can't be established.
ECDSA key fingerprint is SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/хххххх.
Are you sure you want to continue connecting (yes/no/[fingerprint])? y
Please type 'yes', 'no' or the fingerprint: yes
Warning: Permanently added 'github.com,140.82.121.4' (ECDSA) to the list of known hosts.
Hi LegoBro007! You've successfully authenticated, but GitHub does not provide shell access.
alegach@ubuntu:~$ ssh -T git@github.com
Warning: Permanently added the ECDSA host key for IP address '140.82.121.3' to the list of known hosts.
Hi LegoBro007! You've successfully authenticated, but GitHub does not provide shell access.


5. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

Чтобы сделать задание 6, все же пришлось генерить ключи и для своей машинки localhost. Сгенерировал предыдущим методом из задания 5. Далее создал файл конфигурации SSH, добавил в него следующее 


alegach@ubuntu:~$ vim ~/.ssh/config

Host alegach
  User alegach
  HostName 127.0.0.1
  IdentityFile ~/.ssh/testsshkey


Проверяю подключение:

alegach@ubuntu:~$ ssh -i ~/.ssh/testsshkey alegach
alegach@127.0.0.1's password: 
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.13.0-51-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

15 updates can be applied immediately.
To see these additional updates run: apt list --upgradable

Your Hardware Enablement Stack (HWE) is supported until April 2025.
Last login: Sun Jun 19 07:35:19 2022 from 127.0.0.1

7.Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

alegach@ubuntu:~$ sudo tcpdump -c 100 -w security7_1.cap
tcpdump: listening on ens33, link-type EN10MB (Ethernet), capture size 262144 bytes
100 packets captured
103 packets received by filter
0 packets dropped by kernel



