Домашнее задание к занятию "3.5. Файловые системы

1. Узнайте о sparse (разряженных) файлах.

Прочитал

2. Могут ли файлы, являющиеся жесткой ссылкой на один объект, иметь разные права доступа и владельца? Почему?

Жесткая ссылка это по сути зеркальная копия объекта, наследующая его права, владельца и группу. Имеет тот же inode что и оригинальный файл.
Поэтому разных владельцев и разные права оригинал и хардлинк иметь не могут.

3. Сделайте vagrant destroy на имеющийся инстанс Ubuntu

Так как у меня стоит виртуалка с помощью VMWare, то не увидел смысла делать дополнительно Вагрантовскую ВМ для этого задания. 
Вместо этого я добавил 2 виртуальных диска по 5 ГБ каждый.


4. Используя fdisk, разбейте первый диск на 2 раздела: 2 Гб, оставшееся пространство

root@ubuntu:~# fdisk /dev/sda

Welcome to fdisk (util-linux 2.34).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x5c7a0a61.

Command (m for help): g
Created a new GPT disklabel (GUID: A0B8B2E1-75DD-A74C-A1C5-755C673EC82A).

Command (m for help): n
Partition number (1-128, default 1): 
First sector (2048-10485726, default 2048): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-10485726, default 10485726): +2G

Created a new partition 1 of type 'Linux filesystem' and of size 2 GiB.

Command (m for help): n
Partition number (2-128, default 2): 
First sector (4196352-10485726, default 4196352): 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (4196352-10485726, default 10485726): 

Created a new partition 2 of type 'Linux filesystem' and of size 3 GiB.

Command (m for help): p
Disk /dev/sda: 5 GiB, 5368709120 bytes, 10485760 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A0B8B2E1-75DD-A74C-A1C5-755C673EC82A

Device       Start      End Sectors Size Type
/dev/sda1     2048  4196351 4194304   2G Linux filesystem
/dev/sda2  4196352 10485726 6289375   3G Linux filesystem


5. Используя sfdisk, перенесите данную таблицу разделов на второй диск.


root@ubuntu:~# sfdisk -d /dev/sda | sfdisk /dev/sdc
Checking that no-one is using this disk right now ... OK

Disk /dev/sdc: 5 GiB, 5368709120 bytes, 10485760 sectors
Disk model: VMware Virtual S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Script header accepted.
>>> Created a new GPT disklabel (GUID: A0B8B2E1-75DD-A74C-A1C5-755C673EC82A).
/dev/sdc1: Created a new partition 1 of type 'Linux filesystem' and of size 2 GiB.
/dev/sdc2: Created a new partition 2 of type 'Linux filesystem' and of size 3 GiB.
/dev/sdc3: Done.

New situation:
Disklabel type: gpt
Disk identifier: A0B8B2E1-75DD-A74C-A1C5-755C673EC82A

Device       Start      End Sectors Size Type
/dev/sdc1     2048  4196351 4194304   2G Linux filesystem
/dev/sdc2  4196352 10485726 6289375   3G Linux filesystem

The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

6. Соберите mdadm RAID1 на паре разделов 2 Гб.

root@ubuntu:~# mdadm --create --verbose /dev/md0 -l 1 -n 2 /dev/sd{a1,c1}
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 2094080K
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md0 started.


7. Соберите mdadm RAID0 на второй паре маленьких разделов.


root@ubuntu:~# mdadm --create --verbose /dev/md1 -l 0 -n 2 /dev/sd{a2,c2}
mdadm: chunk size defaults to 512K
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md1 started.


root@ubuntu:~# cat /proc/mdstat
Personalities : [raid1] [raid0] 
md1 : active raid0 sdc2[1] sda2[0]
      6282240 blocks super 1.2 512k chunks
      
md0 : active raid1 sdc1[1] sda1[0]
      2094080 blocks super 1.2 [2/2] [UU]

8. Создайте 2 независимых PV на получившихся md-устройствах.

root@ubuntu:~# pvcreate /dev/md0 /dev/md1
  Physical volume "/dev/md0" successfully created.
  Physical volume "/dev/md1" successfully created.


9. Создайте общую volume-group на этих двух PV.

root@ubuntu:~# vgcreate vg1 /dev/md0 /dev/md1
  Volume group "vg1" successfully created


10. Создайте LV размером 100 Мб, указав его расположение на PV с RAID0.

root@ubuntu:~# lvcreate -L 100M vg1 /dev/md1
  Logical volume "lvol0" created.


11. Создайте mkfs.ext4 ФС на получившемся LV.

root@ubuntu:~# mkfs.ext4 /dev/vg1/lvol0
mke2fs 1.45.5 (07-Jan-2020)
Creating filesystem with 25600 4k blocks and 25600 inodes

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done


12. Смонтируйте этот раздел в любую директорию, например, /tmp/new.

root@ubuntu:~# mkdir /tmp/new
root@ubuntu:~# mount /dev/vg1/lvol0 /tmp/new


13. Поместите туда тестовый файл, например wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz.

root@ubuntu:~# wget https://mirror.yandex.ru/ubuntu/ls-lR.gz -O /tmp/new/test.gz
--2022-05-23 11:51:55--  https://mirror.yandex.ru/ubuntu/ls-lR.gz
Resolving mirror.yandex.ru (mirror.yandex.ru)... 213.180.204.183, 2a02:6b8::183
Connecting to mirror.yandex.ru (mirror.yandex.ru)|213.180.204.183|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 23304116 (22M) [application/octet-stream]
Saving to: ‘/tmp/new/test.gz’

/tmp/new/test.gz                100%[=====================================================>]  22.22M  8.94MB/s    in 2.5s    

2022-05-23 11:51:57 (8.94 MB/s) - ‘/tmp/new/test.gz’ saved [23304116/23304116]


14. Прикрепите вывод lsblk.

oot@ubuntu:~# lsblk -p
NAME                        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
/dev/loop0                    7:0    0  55.5M  1 loop  /snap/core18/2344
/dev/loop1                    7:1    0  61.9M  1 loop  /snap/core20/1405
/dev/loop2                    7:2    0     4K  1 loop  /snap/bare/5
/dev/loop3                    7:3    0  65.2M  1 loop  /snap/gtk-common-themes/1519
/dev/loop4                    7:4    0  54.2M  1 loop  /snap/snap-store/558
/dev/loop5                    7:5    0  44.7M  1 loop  /snap/snapd/15534
/dev/loop6                    7:6    0   9.5M  1 loop  /snap/htop/3390
/dev/loop7                    7:7    0  81.3M  1 loop  /snap/gtk-common-themes/1534
/dev/loop8                    7:8    0  43.6M  1 loop  /snap/snapd/15177
/dev/loop9                    7:9    0  61.9M  1 loop  /snap/core20/1434
/dev/loop10                   7:10   0   219M  1 loop  /snap/gnome-3-34-1804/72
/dev/loop11                   7:11   0 105.7M  1 loop  /snap/slack/62
/dev/loop12                   7:12   0    51M  1 loop  /snap/snap-store/547
/dev/loop13                   7:13   0 565.1M  1 loop  /snap/pycharm-community/276
/dev/loop14                   7:14   0 103.1M  1 loop  /snap/slack/61
/dev/loop15                   7:15   0 248.8M  1 loop  /snap/gnome-3-38-2004/99
/dev/loop16                   7:16   0  55.5M  1 loop  /snap/core18/2409
/dev/loop17                   7:17   0   219M  1 loop  /snap/gnome-3-34-1804/77
/dev/loop18                   7:18   0 565.5M  1 loop  /snap/pycharm-community/278
/dev/sda                      8:0    0     5G  0 disk  
├─/dev/sda1                   8:1    0     2G  0 part  
│ └─/dev/md0                  9:0    0     2G  0 raid1 
└─/dev/sda2                   8:2    0     3G  0 part  
  └─/dev/md1                  9:1    0     6G  0 raid0 
    └─/dev/mapper/vg1-lvol0 253:0    0   100M  0 lvm   /tmp/new
/dev/sdb                      8:16   0    20G  0 disk  
├─/dev/sdb1                   8:17   0   512M  0 part  /boot/efi
├─/dev/sdb2                   8:18   0     1K  0 part  
└─/dev/sdb5                   8:21   0  19.5G  0 part  /
/dev/sdc                      8:32   0     5G  0 disk  
├─/dev/sdc1                   8:33   0     2G  0 part  
│ └─/dev/md0                  9:0    0     2G  0 raid1 
└─/dev/sdc2                   8:34   0     3G  0 part  
  └─/dev/md1                  9:1    0     6G  0 raid0 
    └─/dev/mapper/vg1-lvol0 253:0    0   100M  0 lvm   /tmp/new
/dev/sr0                     11:0    1  1024M  0 rom   

15. Протестируйте целостность файла

root@ubuntu:~# gzip -t /tmp/new/test.gz
root@ubuntu:~# echo $?
0

16. Используя pvmove, переместите содержимое PV с RAID0 на RAID1.

root@ubuntu:~# pvmove /dev/md1
  /dev/md1: Moved: 96.00%


17. Сделайте --fail на устройство в вашем RAID1 md.

root@ubuntu:~# mdadm --fail /dev/md0 /dev/sda1
mdadm: set /dev/sda1 faulty in /dev/md0


18. Подтвердите выводом dmesg, что RAID1 работает в деградированном состоянии.

[ 4478.756629] md/raid1:md0: Disk failure on sda1, disabling device.
               md/raid1:md0: Operation continuing on 1 devices.


19. Протестируйте целостность файла, несмотря на "сбойный" диск он должен продолжать быть доступен

root@ubuntu:~# gzip -t /tmp/new/test.gz
root@ubuntu:~# echo $?
0

20. Погасите тестовый хост

Пока выполненные диски не удалял, но сделать не составляет труда.


