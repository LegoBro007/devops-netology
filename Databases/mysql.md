# **Домашнее задание к занятию "6.3. MySQL"**

**Задача 1**
------------
Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.
Изучите бэкап БД и восстановитесь из него.
Перейдите в управляющую консоль mysql внутри контейнера.

    root@alegachev-virtual-machine:~# docker pull mysql:8.0
    root@alegachev-virtual-machine:~# docker volume create volume_mysql
    volume_mysql
    root@alegachev-virtual-machine:~# docker run --rm --name mysql-docker -e MYSQL_ROOT_PASSWORD=mysql -ti -p 3306:3306 -v vol_mysql:/etc/mysql/ mysql:8.0
       root@alegachev-virtual-machine:~# docker cp test_dump.sql mysql-docker:/etc/mysql/backup/test_dump.sql
       bash-4.4# mysql -u root -p < /etc/mysql/backup/test_dump.sql


Используя команду \h получите список управляющих команд.

Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.

       mysql> USE mysql_test
       Database changed
       mysql> status

       mysql  Ver 8.0.30 for Linux on x86_64 (MySQL Community Server - GPL)

       Connection id:          18
       Current database:       mysql_test
       Current user:           root@127.0.0.1
       SSL:                    Cipher in use is TLS_AES_256_GCM_SHA384
       Current pager:          stdout
       Using outfile:          ''
       Using delimiter:        ;
       Server version:         8.0.30 MySQL Community Server - GPL
       Protocol version:       10
       Connection:             127.0.0.1 via TCP/IP
       Server characterset:    utf8mb4
       Db     characterset:    utf8mb4
       Client characterset:    latin1
       Conn.  characterset:    latin1
       TCP port:               3306
       Binary data as:         Hexadecimal
       Uptime:                 1 hour 56 min 7 sec
       Threads: 2  Questions: 132  Slow queries: 0  Opens: 165  Flush tables: 3  Open tables: 83  Queries per second avg: 0.018

Подключитесь к восстановленной БД и получите список таблиц из этой БД.
      
        mysql> show tables
           -> ;
       +----------------------+
       | Tables_in_mysql_test |
       +----------------------+
       | orders               |
       +----------------------+
       1 row in set (0.00 sec)

Приведите в ответе количество записей с price > 300.

       mysql> SELECT * FROM orders WHERE price > 300;
       +----+----------------+-------+
       | id | title          | price |
       +----+----------------+-------+
       |  2 | My little pony |   500 |
       +----+----------------+-------+
       1 row in set (0.00 sec)

В следующих заданиях мы будем продолжать работу с данным контейнером.

**Задача 2**
----
Создайте пользователя test в БД c паролем test-pass, используя:

- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней
- количество попыток авторизации - 3
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
       Фамилия "Pretty"
       Имя "James"


       mysql> CREATE USER test
    -> IDENTIFIED WITH mysql_native_password BY 'test-pass'
    -> WITH MAX_QUERIES_PER_HOUR 100
    -> PASSWORD EXPIRE INTERVAL 180 DAY
    -> FAILED_LOGIN_ATTEMPTS 3
    -> ATTRIBUTE '{"fname": "Pretty", "lname": "James"}';
       Query OK, 0 rows affected (0.02 sec)

Предоставьте привелегии пользователю test на операции SELECT базы test_db.

       mysql> GRANT SELECT ON mysql_test.* TO test;
       Query OK, 0 rows affected (0.01 sec)

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю test и приведите в ответе к задаче.

       mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE user='test';
       +------+------+---------------------------------------+
       | USER | HOST | ATTRIBUTE                             |
       +------+------+---------------------------------------+
       | test | %    | {"fname": "Pretty", "lname": "James"} |
       +------+------+---------------------------------------+
       1 row in set (0.02 sec)


**Задача 3**

Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES;.

       mysql> SET profiling = 1;
       Query OK, 0 rows affected, 1 warning (0.02 sec)
       mysql> SHOW PROFILES;
       +----------+------------+------------------+
       | Query_ID | Duration   | Query            |
       +----------+------------+------------------+
       |        1 | 0.01757825 | FLUSH PRIVILEGES |
       |        2 | 0.00013850 | SET profiling = 1 |
       +----------+------------+------------------+
       1 row in set, 1 warning (0.00 sec)


Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.

       mysql> show table status from mysql_test;

       | Engine | 
       | InnoDB |
Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:

- на MyISAM
- на InnoDB

       mysql> ALTER TABLE orders ENGINE = MyISAM;
       Query OK, 5 rows affected (0.03 sec)
       Records: 5  Duplicates: 0  Warnings: 0

       mysql> ALTER TABLE orders ENGINE = InnoDB;
       Query OK, 5 rows affected (0.02 sec)
       Records: 5  Duplicates: 0  Warnings: 0


**Задача 4**

Изучите файл my.cnf в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):

- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл my.cnf.

    bash-4.4# cat /etc/mysql/my.cnf

    [mysqld]
    pid-file        = /var/run/mysqld/mysqld.pid
    socket          = /var/run/mysqld/mysqld.sock
    datadir         = /var/lib/mysql
    secure-file-priv= NULL

    innodb_flush_log_at_trx_commit  = 2
    innodb_file_format              = Barracuda
    innodb_log_buffer_size          = 1M
    key_buffer_size                 = 614M
    innodb_log_file_size            = 100M