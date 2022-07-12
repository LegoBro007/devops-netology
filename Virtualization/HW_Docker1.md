Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

Задача 1

Сценарий выполения задачи:

    создайте свой репозиторий на https://hub.docker.com;
    выберете любой образ, который содержит веб-сервер Nginx;
    создайте свой fork образа;
    реализуйте функциональность: запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:

<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>


Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

---------------------------------------------------------------------------

Репозиторий создал, выбрал nginx офиц. образ. Для того, чтобы его скачать, создал Dockerfail со следующим содержимым:

FROM nginx:latest
COPY ./index.html /usr/share/nginx/html/index.html

Создал index.html в корневой папке для докера с содержимым выше в задании.
Запустил сборку образа:

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker build -t alegachev2-nginx .
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM nginx:latest
 ---> 55f4b40fe486
Step 2/2 : COPY ./index.html /usr/share/nginx/html/index.html
 ---> dd586371cea7
Successfully built dd586371cea7
Successfully tagged alegachev2-nginx:latest

Запускаю контейнер:

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker run -it -d -p 8080:80 --name nginx alegachev2-nginx
63430fe5423ae120c87981636565cf99408091921825c31be31d16a1b2731245

Проверяю запущенные контейнеры:

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker ps
CONTAINER ID   IMAGE              COMMAND                  CREATED          STATUS          PORTS                                   NAMES
63430fe5423a   alegachev2-nginx   "/docker-entrypoint.…"   20 seconds ago   Up 18 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx

И скачанные образы:

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker images
REPOSITORY         TAG       IMAGE ID       CREATED         SIZE
alegachev2-nginx   latest    dd586371cea7   2 minutes ago   142MB
nginx              latest    55f4b40fe486   2 weeks ago     142MB

![image](https://user-images.githubusercontent.com/102428034/178475686-22ec7ecb-7c12-4a26-b2cb-527fc6e3480c.png)

Добавляю тэг к текущей сборке:

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker tag dd586371cea7 alegachev2-nginx:0.1

Еще раз смотрю образы, убеждаюсь, что есть и затегированная сборка и предыдущая (latest):

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker images
REPOSITORY         TAG       IMAGE ID       CREATED         SIZE
alegachev2-nginx   0.1       dd586371cea7   6 minutes ago   142MB
alegachev2-nginx   latest    dd586371cea7   6 minutes ago   142MB
nginx              latest    55f4b40fe486   2 weeks ago     142MB

Так как оказалось, что необходимо совпадение названия локального репозитория с имаджем и с удаленным, то меняю имя имаджа

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker image tag dd586371cea7 legobro/alegachev2-nginx:0.1

Отправляю на Dockerhub:

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker push legobro/alegachev2-nginx:0.1
The push refers to repository [docker.io/legobro/alegachev2-nginx]
018151185a0e: Pushed 
e7344f8a29a3: Pushed 
44193d3f4ea2: Pushed 
41451f050aa8: Pushed 
b2f82de68e0d: Pushed 
d5b40e80384b: Pushed 
08249ce7456a: Pushed 
0.1: digest: sha256:196aab3e3e7655ed2e46910670e619d6f5b85befc8e69206b9d06a69df0469cf size: 1777

Образ можно посмотреть в паблик репозитории здесь:

https://hub.docker.com/repository/docker/legobro/alegachev2-nginx


Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос: "Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

Высоконагруженное монолитное java веб-приложение;

    Высоконагруженные приложения лучше держать на физических машинках. Использование Докера не имеет смысла, так как приложение монолитное

Nodejs веб-приложение;
    
    Docker заходит, так как будет иметь достаточную масштабируемость, скорость работы и развертываемости + независимость от инфраструтуры


Мобильное приложение c версиями для Android и iOS;

     По IOS - это невозможно. Apple выступила против компаний, которые предлагали этот тип услуг или любую виртуализацию операционной системы macOS/iOS, поскольку использование ее за пределами их собственного оборудования и экосистемы противоречит их условиям использования.

    Для Andoid докер валиден для использования

Шина данных на базе Apache Kafka;

    Особенность шины кафка в том, что она позволяет на ранних этапах заложить в архитектуру бэкенда структуры, которые можно беспроблемно масштабировать в    будущем. Подозреваю, что Docker может помочь при масштабировании

Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
 
    Docker очень даже подходит,реализовать кластерное решение можно будет без особых трудностей

Мониторинг-стек на базе Prometheus и Grafana;

    Docker прекрасно подходит, особенно при росте продуктов и масштабировании мониторинга на них.

MongoDB, как основное хранилище данных для java-приложения;

    Я бы держал DB в более классических вариантах - на физических машинах и ВМ, однако, по офиц. документации ничего не мешает разворачивать Докер для MongoDB.

Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

    Docker подходит.



Задача 3

    Запустите первый контейнер из образа centos c любым тэгом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
    Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера;
    Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data;
    Добавьте еще один файл в папку /data на хостовой машине;
    Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.


Скачиваю и запускаю контейнер с образом centos: 

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker run -it -d -v /data:/data --name centos centos
Unable to find image 'centos:latest' locally
latest: Pulling from library/centos
a1d0c7532777: Pull complete 
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177
Status: Downloaded newer image for centos:latest
5c0f081d3e8b65f7ab0b872bdc6baab6b522513afaa825bbd1e485cac4ee90ec

Скачиваю и запускаю контейнер с образом debian:

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker run -it -d -v /data:/data --name debian debian
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
1339eaac5b67: Pull complete 
Digest: sha256:859ea45db307402ee024b153c7a63ad4888eb4751921abbef68679fc73c4c739
Status: Downloaded newer image for debian:latest
a1f2e234a638c8587327401a7e5081bed6e41f2299a28d25abea98653e710a85

Образы скачаны, контейнеры запущены:

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker ps
CONTAINER ID   IMAGE                  COMMAND                  CREATED              STATUS              PORTS                                   NAMES
a1f2e234a638   debian                 "bash"                   52 seconds ago       Up 51 seconds                                               debian
5c0f081d3e8b   centos                 "/bin/bash"              About a minute ago   Up About a minute                                           centos
71f045b5816e   alegachev2-nginx:0.1   "/docker-entrypoint.…"   21 minutes ago       Up 21 minutes       0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx

Подключаюсь к первому контейнеру и создаю текстовый файл

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# docker exec -it centos bash
[root@5c0f081d3e8b /]# touch /data/test_centos.txt
[root@5c0f081d3e8b /]# exit
exit

Подключаюсь ко второму контейнеры и создаю текстовый файл на хосте

root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker# sudo touch /data/test_host.txt
root@alegachev-virtual-machine:/home/alegachev/devops-netology/Docker#  docker exec -it debian bash

Смотрю какие файлы есть на хостовой машине

root@a1f2e234a638:/# ls /data
test_centos.txt  test_host.txt
root@a1f2e234a638:/# exit
exit





