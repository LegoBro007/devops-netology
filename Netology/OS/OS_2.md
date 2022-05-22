Домашнее задание "Операционные системы 3.4. Лекция 2".

1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:

   -  поместите его в автозагрузку,
   -  предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
    - удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

-------------------------------------
1.1. Сначала установил node_exporter.
1.2. Далее открыл конфигурационный файл 
alegach@ubuntu:~/Downloads/node_exporter-1.3.1.linux-amd64$ sudo nano /etc/systemd/system/node_exporter.service
1.3. Изменил его, добавив следующее описание:
[Unit]
Description=Node Exporter

[Service]
EnvironmentFile=-/etc/default/node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
1.4.Инициировал старт процесса 
alegach@ubuntu:~/Downloads/node_exporter-1.3.1.linux-amd64$ sudo systemctl start node_exporter
1.5. Погрепал процессы, убедился, что он стартанул
alegach@ubuntu:~/Downloads/node_exporter-1.3.1.linux-amd64$ systemctl list-units --all | grep node
  kmod-static-nodes.service                                                                                loaded    active     exited    Create list of static device nodes for the current kernel                                                        
  node_exporter.service                                                                                    loaded    active     running   Node Exporter  

1.6. Рестартнул демон, чтобы убедиться, что процесс запутится снова.
alegach@ubuntu:~/Downloads/node_exporter-1.3.1.linux-amd64$ sudo systemctl daemon-reload
1.7. Процесс перезапустился. Заэнеблил автозагрузку с помощью sudo systemctl enable node_exporter
1.8. Перезапустил машину, процесс запустился

alegach@ubuntu:~$ sudo systemctl status node_exporter
[sudo] password for alegach: 
● node_exporter.service - Node Exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor>
     Active: active (running) since Sun 2022-05-22 03:22:11 PDT; 42s ago
   Main PID: 934 (node_exporter)
      Tasks: 6 (limit: 4583)
     Memory: 13.4M
     CGroup: /system.slice/node_exporter.service
             └─934 /usr/local/bin/node_exporter


2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.
----------------------
2.1. Пошел смотреть метрики через проброшенный порт 9100 
alegach@ubuntu:~$ curl -s http://192.168.157.129:9100/metrics | grep cpu
2.2. Грепаю базовые параметры:
ЦПУ:
node_cpu_guest_seconds_total
node_cpu_seconds_total
node_pressure_cpu_waiting_seconds_total
node_schedstat_running_seconds_total
node_schedstat_waiting_seconds_total
process_cpu_seconds_total 0.05
Memory:
process_virtual_memory_max_bytes
node_memory_Inactive_bytes
node_memory_Active_anon_bytes
node_memory_Cached_bytes gauge
и другое
Network:
node_network_receive_errs_total{device="eth0"} 
node_network_receive_bytes_total{device="eth0"} 
node_network_transmit_bytes_total{device="eth0"}
node_network_transmit_errs_total{device="eth0"}
Disk:
node_disk_read_bytes_total
node_disk_written_bytes_total
node_disk_reads_completed_total

--------------------
3. Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:

    в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,
    добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:

config.vm.network "forwarded_port", guest: 19999, host: 19999

После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.
--------------
Пробросил, ознакомился :) Даже не знаю, что еще тут могу написать, но тул удобный, графики полезные при траблшуте или общем мониторинге системы
-------------

4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации

-----------------------
Можно погрепать vmware(в моем случае) и убедится в наличии виртуальной машинки
alegach@ubuntu:~$ dmesg | grep vmware
[    0.000000] vmware: hypercall mode: 0x02
[    0.000000] vmware: TSC freq read from hypervisor : 3696.004 MHz
[    0.000000] vmware: Host bus clock speed read from hypervisor : 66000000 Hz
[    0.000000] vmware: using clock offset of 9332366816 ns
[    2.044655] systemd[1]: Detected virtualization vmware.

5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

По умолчанию fs.nr_open настроен:
alegach@ubuntu:~$ /sbin/sysctl -n fs.nr_open
1048576

Это максималльное число дескрипторов для ядра системы.

Softlimit - число лимитированных ресурсов для обычнго пользователя, который можно изменить в рамках жестких лимитов, назначенным администратором

Соответственно, оба лимита ограничивают юзера для достижения максимального значения
-------------
6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

----------------------------

root@ubuntu:~# unshare -f --pid --mount-proc sleep 1h
^Z
[1]+  Stopped                 unshare -f --pid --mount-proc sleep 1h
root@ubuntu:~# ps -e | grep sleep
   4658 pts/0    00:00:00 sleep
   4763 pts/0    00:00:00 sleep



root@ubuntu:~# nsenter --target 4763 --pid --mount
root@ubuntu:/# ps
    PID TTY          TIME CMD
      1 pts/0    00:00:00 sleep
      2 pts/0    00:00:00 bash
     11 pts/0    00:00:00 ps

-------------------------------

7. 

В действительности эта команда является логической бомбой. Она оперирует определением функции с именем ‘:‘, которая вызывает сама себя дважды: один раз на переднем плане и один раз в фоне. Она продолжает своё выполнение снова и снова, пока система не зависнет.

Процесс, который помогает системе восстановится хоть как-то (в случае Vmware) получилось хотя бы ребутнуться и поработать с тем, что уже открыто, но, новый терминал открыть не получилось, видимо все процессы уже были заняты.

[ 2719.054979] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/user@1000.service
-------------------------------------
