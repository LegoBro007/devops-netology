**Домашнее задание к занятию "6.4. PostgreSQL"**

**Задача 1.**

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя psql.

Воспользуйтесь командой \? для вывода подсказки по имеющимся в psql управляющим командам.

Найдите и приведите управляющие команды для:

- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql


      root@alegachev-virtual-machine:~# docker pull postgres:13
      root@alegachev-virtual-machine:~# docker volume create vol_postgres
      vol_postgres
      root@alegachev-virtual-machine:~# docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v vol_postgres:/var/lib/postgresql/data postgres:13
      root@alegachev-virtual-machine:~# docker ps
      CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS          PORTS                                       NAMES
      d5b1de2d017e   postgres:13   "docker-entrypoint.s…"   31 seconds ago   Up 28 seconds   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   pg-docker
      root@alegachev-virtual-machine:~# docker exec -it d5b1de2d017e /bin/bash
      root@d5b1de2d017e:/# psql -h localhost -p 5432 -U postgres -W

      postgres=# \l
                                 List of databases
         Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
      -----------+----------+----------+------------+------------+-----------------------
       postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
       template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
                 |          |          |            |            | postgres=CTc/postgres
       template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
                 |          |          |            |            | postgres=CTc/postgres
      (3 rows)
----
    postgres=# \c postgres
    postgres=# \dtS
                        List of relations
       Schema   |          Name           | Type  |  Owner   
    ------------+-------------------------+-------+----------
    pg_catalog | pg_aggregate            | table | postgres
    pg_catalog | pg_am                   | table | postgres
    pg_catalog | pg_amop                 | table | postgres
    pg_catalog | pg_amproc               | table | postgres
    pg_catalog | pg_attrdef              | table | postgres
    pg_catalog | pg_attribute            | table | postgres
    pg_catalog | pg_auth_members         | table | postgres
    pg_catalog | pg_authid               | table | postgres
    pg_catalog | pg_cast                 | table | postgres
    pg_catalog | pg_class                | table | postgres
    pg_catalog | pg_collation            | table | postgres
----
    postgres=# \dS+ pg_tables
                          View "pg_catalog.pg_tables"
      Column    |  Type   | Collation | Nullable | Default | Storage | Description 
    -------------+---------+-----------+----------+---------+---------+-------------
    schemaname  | name    |           |          |         | plain   | 
    tablename   | name    |           |          |         | plain   | 
    tableowner  | name    |           |          |         | plain   | 
    tablespace  | name    |           |          |         | plain   | 
    hasindexes  | boolean |           |          |         | plain   | 
    hasrules    | boolean |           |          |         | plain   | 
    hastriggers | boolean |           |          |         | plain   | 
    rowsecurity | boolean |           |          |         | plain   | 
      View definition:
    SELECT n.nspname AS schemaname,
    c.relname AS tablename,
    pg_get_userbyid(c.relowner) AS tableowner,
    t.spcname AS tablespace,
    c.relhasindex AS hasindexes,
    c.relhasrules AS hasrules,
    c.relhastriggers AS hastriggers,
     c.relrowsecurity AS rowsecurity
       FROM pg_class c
     LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
     LEFT JOIN pg_tablespace t ON t.oid = c.reltablespace
    WHERE c.relkind = ANY (ARRAY['r'::"char", 'p'::"char"]);
----
    postgres=# \q

**Задача 2**

Используя psql создайте БД test_database.

Изучите бэкап БД.

Восстановите бэкап БД в test_database.

Перейдите в управляющую консоль psql внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.

Приведите в ответе команду, которую вы использовали для вычисления и полученный результат.

    root@d5b1de2d017e:~# psql -U postgres -d test_database < /var/lib/postgresql/data/backup/postgres_dump.sql
    SET
    SET
    SET
    SET
    SET
    set_config 
    ------------
     
    (1 row)
    
    SET
    SET
    SET
    SET
    SET
    SET
    CREATE TABLE
    ALTER TABLE
    CREATE SEQUENCE
    ALTER TABLE
    ALTER SEQUENCE
    ALTER TABLE
    COPY 8
    setval  
    --------
      8
    (1 row)

    ALTER TABLE
----
    test_database=# select avg_width, attname FROM pg_stats WHERE tablename = 'orders' ORDER by attname DESC LIMIT 1;
    avg_width | attname 
    -----------+---------
           16 | title
    (1 row)

**Задача 3**

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?


    test_database=# begin;
    create table orders_new (
        id integer NOT NULL,
        title varchar(80) NOT NULL,
        price integer) partition by range(price);
    create table orders_1 partition of orders_new for values from (0) to (499);
    create table orders_2 partition of orders_new for values from (499) to (10000);
    insert into orders_new (id, title, price) select * from orders;
    commit;

Исключить ручное разбиение можно было, если бы с самого начала была создана partitioned таблица

**Задача 4**

Используя утилиту pg_dump создайте бекап БД test_database.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?

        root@d5b1de2d017e:~# pg_dump -U postgres -d test_database > /var/lib/postgresql/data/backup/postgres_dump_25092022.sql
        
Чтобы добавить уникальность значения столбца title, можно добавить индекс

        root@d5b1de2d017e:~# ALTER TABLE ONLY public.orders ADD CONSTRAINT title_unique UNIQUE (title);
