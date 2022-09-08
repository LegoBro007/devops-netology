Домашнее задание к занятию "6.2. SQL"

Задача 1.

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы. 

     root@alegachev-virtual-machine:~# docker volume create vol2
     vol2
      root@alegachev-virtual-machine:~# docker volume create vol1
    vol1
    root@alegachev-virtual-machine:~# docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v vol1:/var/lib/postgresql/data -v vol2:/var/lib/postgresql postgres:12
    root@alegachev-virtual-machine:~#  docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v vol1:/var/lib/postgresql/data -v vol2:/var/lib/postgresql postgres:12
    root@alegachev-virtual-machine:~# docker volume ls
    DRIVER    VOLUME NAME
    local     vol1
    local     vol2

Задача 2.

В БД из задачи 1:

- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db 
````
root@6260097bbd26:/# psql -h localhost -p 5432 -U postgres -W

postgres=# CREATE DATABASE test_db;
postgres=# \l
                                 List of databases
Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 |


postgres=# CREATE ROLE "test-admin-user" SUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
postgres=# \du
                                      List of roles
    Role name    |                         Attributes                         | Member of 
-----------------+------------------------------------------------------------+-----------
postgres        | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
test-admin-user | Superuser, No inheritance                                  | {}

postgres=# CREATE TABLE orders
(
id integer,
name text,
price integer,
PRIMARY KEY (id)
);
CREATE TABLE
postgres=# \dt
         List of relations
Schema |  Name  | Type  |  Owner
--------+--------+-------+----------
public | orders | table | postgres
(1 row)

postgres=# CREATE TABLE clients
(
        id integer PRIMARY KEY,
        lastname text,
        country text,
        booking integer,
        FOREIGN KEY (booking) REFERENCES orders (Id)
);
CREATE TABLE

postgres=# \dt
          List of relations
Schema |  Name   | Type  |  Owner
--------+---------+-------+----------
public | clients | table | postgres
public | orders  | table | postgres

postgres=# CREATE ROLE "test-simple-user" NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN;
GRANT SELECT ON TABLE public.clients TO "test-simple-user";
GRANT INSERT ON TABLE public.clients TO "test-simple-user";
GRANT UPDATE ON TABLE public.clients TO "test-simple-user";
GRANT DELETE ON TABLE public.clients TO "test-simple-user";
GRANT SELECT ON TABLE public.orders TO "test-simple-user";
GRANT INSERT ON TABLE public.orders TO "test-simple-user";
GRANT UPDATE ON TABLE public.orders TO "test-simple-user";
GRANT DELETE ON TABLE public.orders TO "test-simple-user";
CREATE ROLE
GRANT
GRANT
GRANT
GRANT
GRANT
GRANT
GRANT
GRANT
`````
Задача 3.

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными: 

``````
postgres=# insert into orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
insert into clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
select count (*) from orders;
select count (*) from clients;
INSERT 0 5
INSERT 0 5
 count 
-------
     5
(1 row)

 count 
-------
     5
(1 row)
``````

Задача 4.

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders. Используя foreign keys свяжите записи из таблиц, согласно таблице:
````
postgres=# update  clients set booking = 3 where id = 1;
update  clients set booking = 4 where id = 2;
update  clients set booking = 5 where id = 3;
UPDATE 1
UPDATE 1
UPDATE 1

````
Задача 5.

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN). Приведите получившийся результат и объясните что значат полученные значения. 
````
test_db=# explain select * from clients as a where exists (select id from orders as b where a.booking = b.id);
                               QUERY PLAN                               
------------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=72)
   Hash Cond: (a.booking = b.id)
   ->  Seq Scan on clients a  (cost=0.00..18.10 rows=810 width=72)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=4)
         ->  Seq Scan on orders b  (cost=0.00..22.00 rows=1200 width=4)
(5 rows)
````
Задача 6.

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
Остановите контейнер с PostgreSQL (но не удаляйте volumes).
Поднимите новый пустой контейнер с PostgreSQL.
Восстановите БД test_db в новом контейнере.
Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

````
root@00c51a05c457:~# pg_dump -U postgres -W -F t test_db > /var/lib/postgresql/back_up.tar
root@alegachev-virtual-machine:~# docker stop 00c51a05c457

Запустил следующий докер контейнер 
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                                 NAMES
a5af2cc1a386   postgres:12   "docker-entrypoint.s…"   43 seconds ago   Up 42 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp             pg-docker2
bd706ca32e21   postgres:12   "docker-entrypoint.s…"   8 minutes ago    Up 8 minutes    5432/tcp, 0.0.0.0:5432->5434/tcp, :::5434->5434/tcp   pg-docker

root@alegachev-virtual-machine:~# pg_restore -h localhost 5432 -U postgres test_db -v "/var/lib/postgresql/back_up.tar"
````