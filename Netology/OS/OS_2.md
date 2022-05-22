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

1.6. Рестартнул демон, чтобы убедится, что процесс запутится снова.
alegach@ubuntu:~/Downloads/node_exporter-1.3.1.linux-amd64$ sudo systemctl daemon-reload
1.7. Процесс перезапустился.



