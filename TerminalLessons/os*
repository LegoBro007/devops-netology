Домашнее задание к занятию "3.3. Операционные системы, лекция 1"

1. Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, что cd не является самостоятельной программой, это shell builtin, поэтому запустить strace непосредственно на cd не получится. Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. Вам нужно найти тот единственный, который относится именно к cd. Обратите внимание, что strace выдаёт результат своей работы в поток stderr, а не в stdout

chdir("/tmp") 

2. Попробуйте использовать команду file на объекты разных типов на файловой системе. 

Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.

File обращается к множеству файлов и библиотек, примеры ниже:

openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libmagic.so.1", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libbz2.so.1.0", O_RDONLY|O_CLOEXEC) = 3
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) = 3

Сама же база находится здесь:

openat(AT_FDCWD, “/usr/share/misc/magic.mgc”, O_RDONLY) = 3


3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).


4.Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

Зомби-процессы не занимают ресурсы. Они только не освобождают запись в таблице процессов. 
запись освободиться при вызове wait() родительским процессом.

5.В iovisor BCC есть утилита opensnoop:

root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc

На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты?


PID    COMM               FD ERR PATH
908    irqbalance          6   0 /proc/interrupts
908    irqbalance          6   0 /proc/stat
908    irqbalance          6   0 /proc/irq/16/smp_affinity
908    irqbalance          6   0 /proc/irq/16/smp_affinity
908    irqbalance          6   0 /proc/irq/57/smp_affinity
908    irqbalance          6   0 /proc/irq/57/smp_affinity
908    irqbalance          6   0 /proc/irq/19/smp_affinity
908    irqbalance          6   0 /proc/irq/19/smp_affinity
15879  MemoryPoller       51   0 /proc/meminfo
1830   gnome-shell        44   0 /proc/self/stat
1      systemd            21   0 /proc/385/cgroup
15879  MemoryPoller       51   0 /proc/meminfo
894    NetworkManager     23   0 /var/lib/NetworkManager/timestamps.4AU2L1
854    vmtoolsd            9   0 /etc/mtab
854    vmtoolsd           11   0 /proc/devices



6. Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.


- uname

alegach@ubuntu:~/TerminalLessons$ cat uname.log | grep uname
execve("/usr/bin/uname", ["uname", "-a"], 0x7fff59bf0fb8 /* 47 vars */) = 0
uname({sysname="Linux", nodename="ubuntu", ...}) = 0
uname({sysname="Linux", nodename="ubuntu", ...}) = 0
uname({sysname="Linux", nodename="ubuntu", ...}) = 0


-  /proc/version
              This string identifies the kernel version that is currently running.  It includes the contents of  /proc/sys/kernel/ostype,  /proc/sys/kernel/osrelease  and  /proc/sys/kernel/version.
              For example:

        Linux version 1.0.9 (quinlan@phaze) #1 Sat May 14 01:51:54 EDT 1994


7.Чем отличается последовательность команд через ; и через && в bash? Например:
root@netology1:~# test -d /tmp/some_dir; echo Hi
Hi
root@netology1:~# test -d /tmp/some_dir && echo Hi
root@netology1:~#
Есть ли смысл использовать в bash &&, если применить set -e

&& -  условный оператор, который выполняет команду после &&, только в случае, если перед && на выходы оказалось нулевое значение
а ;  - разделитель последовательных команд, т.е. команды можно использовать последовательно используя ;
set -e - прерывает сессию при любом ненулевом значении исполняемых команд в конвеере кроме последней

Похоже большого смысла использовать set -e и && нет, так как команда окончится после && с высокой долей вероятностью не нулем и после этого сессия прервется.


8.Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?

-e  Exit immediately if a command exits with a non-zero status.  
-u  Treat unset variables as an error when substituting.  
-x  Print commands and their arguments as they are executed.  
-o  option-name
      Set the variable corresponding to option-name:
      pipefail      the return value of a pipeline is the status of
                       the last command to exit with a non-zero status,
                       or zero if no command exited with a non-zero status

На мой взгляд, только для того, чтобы корректно залогировать ошибку и прервать сценарий после ее возникновения.

9.Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

alegach@ubuntu:~/TerminalLessons$ ps -o stat
STAT
Ss
S
R+

Самые встречающиеся процессы S* - процессы ожидающие завершения

PROCESS STATE CODES
       Here are the different values that the s, stat and state output specifiers (header "STAT" or "S") will display to describe the state of a process:

               D    uninterruptible sleep (usually IO)
               I    Idle kernel thread
               R    running or runnable (on run queue)
               S    interruptible sleep (waiting for an event to complete)
               T    stopped by job control signal
               t    stopped by debugger during the tracing
               W    paging (not valid since the 2.6.xx kernel)
               X    dead (should never be seen)
               Z    defunct ("zombie") process, terminated but not reaped by its parent

       For BSD formats and when the stat keyword is used, additional characters may be displayed:

               <    high-priority (not nice to other users)
               N    low-priority (nice to other users)
               L    has pages locked into memory (for real-time and custom IO)
               s    is a session leader
               l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
               +    is in the foreground process group





