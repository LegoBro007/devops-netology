Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"


Задача 1

    Опишите своими словами основные преимущества применения на практике IaaC паттернов.

- Конвейерная составляющая процесса позволяющая малыми партиями разработывать -> деплоить на ДЕВ\КУА -> тестировать -> деплоить в прод
- отсутствие большого ответвленности репозитория, за счет мержа всех изменений в одну ветку. Соответственно, и упрощение поиска выполенных изменений по смерженным веткам 
- Сокращение времени поиска issue после очередной доставки, так как изменения выполняются малыми партиями
- автоматизация процесса деплоя, сокращение времени на деплое в КУА\ДЕВ площадках, засчет CD+CD части построенного пайплайна


Какой из принципов IaaC является основополагающим?

Идемпотентность - свойство объекта или операции, при выполнении которой мы получаем стабильный, одинаковый результат, как при первом, так и при последующих использованиях.


Задача 2

    Чем Ansible выгодно отличается от других систем управление конфигурациями?

Ansible прекрасно может использовать уже текущие SSH ключи для подключения к серверам и окружениям. Другие оркестраторы же требуют установки дополнительных PKI-окружений.


    Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?


Каждый из методов выглядит жизнеспособным и может быть использован в зависимости от текущей культуры работы инженеров в компании. Для получения же ожидаемого результата в текущий момент времени - push подходит лучше. Если же есть надобность апдейтить конфигурации раз в месяц, например, и при этом есть уверенность, что они заранее были оттестированы, то pull будет более лучшим решением.


Задача 3

Установить на личный компьютер:

    VirtualBox
    Vagrant
    Ansible

Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.

alegachev@alegachev-virtual-machine:~$ vagrant --version
Vagrant 2.2.19

alegachev@alegachev-virtual-machine:~$ ansible --version
ansible 2.10.8
  config file = None
  configured module search path = ['/home/alegachev/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.4 (main, Apr  2 2022, 09:04:19) [GCC 11.2.0]

alegachev@alegachev-virtual-machine:~$ virtualbox --version
VirtualBox Graphical User Interface Version 6.1.32_Ubuntu r149290
© 2004-2022 Oracle Corporation (Qt5.15.3)




Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

    Создать виртуальную машину.
    Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды

И вот тут начались проблемы :) Я не смог создать ВМ на базе Vagrant ввиду того, что ресурс в РФ заблокирован и образ человеческим способом не скачать. Так как нечеловеческие способы тоже доступны, то образ beno/ubuntu-20.04 скачать я смог. Однако при добавлении его вручую, после чего команда vagrant up завершилась бы успехом выдается следующее. 


alegachev@alegachev-virtual-machine:~$ vagrant box add bento /home/alegachev/devops-netology/Virtualization/bento
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'bento' (v0) for provider: 
    box: Downloading: /home/alegachev/devops-netology/Virtualization/bento
The "metadata.json" file for the box 'bento' was not found.
Boxes require this file in order for Vagrant to determine the
provider it was made for. If you made the box, please add a
"metadata.json" file to it. If someone else made the box, please
notify the box creator that the box is corrupt. Documentation for
box file format can be found at the URL below:

https://www.vagrantup.com/docs/boxes/format.html

json file при этом присутствует, внутри него все как надо = {
"provider":"virtualbox"
}

Побороть это я так и не смог. Пожалуйста, дайте какие-нибудь обходные пути, так как задание сделать охота, а учитывая, что последующие 3 лекции все равно будут использовать Vagrantoвские ВМ, например, тот же Packer, то как быть дальше - не знаю:) Хотел сделать все 4 лекции сразу, так как они логически последовательны, но пока что увы...













