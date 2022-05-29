Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"



1.  Работа c HTTP через телнет.

 Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80
 отправьте HTTP запрос

GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]

В ответе укажите полученный HTTP код, что он означает?

--------------------

Получил код 301 (Redirected),сайт "Переехал". Текущий URL = location: https://stackoverflow.com/questions
--------------------


2. Повторите задание 1 в браузере, используя консоль разработчика F12.


    откройте вкладку Network
    отправьте запрос http://stackoverflow.com
    найдите первый ответ HTTP сервера, откройте вкладку Headers
    укажите в ответе полученный HTTP код.
-----------------------
HTTP/2 200 OK
cache-control: private
content-type: text/html; charset=utf-8
content-encoding: gzip
strict-transport-security: max-age=15552000
x-frame-options: SAMEORIGIN
x-request-guid: c386dc41-8c03-4696-bb5a-4c139902b4fa
feature-policy: microphone 'none'; speaker 'none'
content-security-policy: upgrade-insecure-requests; frame-ancestors 'self' https://stackexchange.com
accept-ranges: bytes
date: Thu, 26 May 2022 19:58:43 GMT
via: 1.1 varnish
x-served-by: cache-hel1410026-HEL
x-cache: MISS
x-cache-hits: 0
x-timer: S1653595123.168760,VS0,VE112
vary: Accept-Encoding,Fastly-SSL
x-dns-prefetch-control: off
X-Firefox-Spdy: h2

-----------------------
    проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?

------------------------
Больше всего времени заняло открытие ресурса 

https://stats.g.doubleclick.net/j/collect?t=dc&aip=1&_r=3&v=1&_v=j96&tid=UA-108242619-1&cid=1190317506.1649608619&jid=1994374998&gjid=2138014141&_gid=1732891075.1653594760&_u=QCCACEAABAAAAC~&z=1532782306

Ответ от ресурса занял 456 ms и завершился НЕ загрузкой объекта.
---------------------------

3. Какой IP адрес у вас в интернете?

Выполнил команду curl https://ipinfo.io/ip
Получил ответ :) 

4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois


----------------------
organisation:   ORG-CHSB2-RIPE
org-name:       JSC "ER-Telecom Holding" Saint-Petersburg Branch
descr:          TM DOM.RU, Saint-Petersburg ISP

origin:         AS51570

------------------------

5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute



6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?




7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig


dns.google.		900	IN	A	8.8.4.4
dns.google.		900	IN	A	8.8.8.8



8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig

;; ANSWER SECTION:
8.8.8.8.in-addr.arpa.	5	IN	PTR	dns.google.




