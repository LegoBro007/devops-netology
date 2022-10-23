**Домашнее задание к занятию "7.4. Средства командной работы над инфраструктурой.**

Задача 2. Написать серверный конфиг для атлантиса.

Смысл задания – познакомиться с документацией о серверной конфигурации и конфигурации уровня репозитория.

Создай server.yaml который скажет атлантису:

- Укажите, что атлантис должен работать только для репозиториев в вашем github (или любом другом) аккаунте.
На стороне клиентского конфига разрешите изменять workflow, то есть для каждого репозитория можно будет указать свои дополнительные команды.
- В workflow используемом по-умолчанию сделайте так, что бы во время планирования не происходил lock состояния.
Создай atlantis.yaml который, если поместить в корень terraform проекта, скажет атлантису:

- Надо запускать планирование и аплай для двух воркспейсов stage и prod.
Необходимо включить автопланирование при изменении любых файлов *.tf.
В качестве результата приложите ссылку на файлы server.yaml и atlantis.yaml.

      

**Задача 3. Знакомство с каталогом модулей.**

В каталоге модулей найдите официальный модуль от aws для создания ec2 инстансов.
Изучите как устроен модуль. Задумайтесь, будете ли в своем проекте использовать этот модуль или непосредственно ресурс aws_instance без помощи модуля?

     Модуль удобен тем, что можно выбрать только необходимые свойства для EC2 инстанса, т.е. это заранее заготовленный шаблон, где указываешь необходимые параметры, а не нужные удаляешь из шаблона.
     Разок поиспользовал бы, чтобы не тратить время на перечисление параметров, а просто взял бы нужные.
     
     Еще здорово, что и терраформ заботится о нас, и AWS тоже 
      ![](/home/alegachev/Pictures/Screenshots/Screenshot from 2022-10-23 17-08-16.png)
В рамках предпоследнего задания был создан ec2 при помощи ресурса aws_instance. Создайте аналогичный инстанс при помощи найденного модуля.

      Взял Яндексовский подобный модуль, правда нашел только чей-то кастомный.
      https://registry.terraform.io/modules/hamnsk/vpc/yandex/latest

В качестве результата задания приложите ссылку на созданный блок конфигураций.

      Добавил модуль в providers.tf
````terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

module "vpc" {
  source  = "hamnsk/vpc/yandex"
  version = "0.5.0"
  # insert the 1 required variable here
  name    = "vpc_test"
  ````
  
  
  
  -------------------------------------------------------------------

      Добавил необходимые модулю variables в соответствующем скачанном, с помощью providers.tf + terraform init файле
````
variable "create_folder" {
  type        = bool
  default     = false
}

variable "yc_cloud_id" {
  description = "Cloud id for deploy resources"
  type        = string
  default     = "b1gju96knd0digar5ljh"
}

variable "yc_folder_id" {
  description = "Folder id for deplot resources"
  type        = string
  default     = "b1gehcd932u7u1rabubf"
}

variable "name" {
  description = "test_vpc"
  type        = string
}

variable "description" {
  description = "An optional description of this resource. Provide this property when you create the resource."
  type        = string
  default     = "Auto-created"
}

variable "subnets" {
  type    = list(object({
    zone           = string
    v4_cidr_blocks = list(string)
  }))
  default = [
    {
      zone           = "ru-central1-a"
      v4_cidr_blocks = ["10.130.0.0/24"]
    },
    {
      zone           = "ru-central1-b"
      v4_cidr_blocks = ["10.129.0.0/24"]
    },
    {
      zone           = "ru-central1-c"
      v4_cidr_blocks = ["10.128.0.0/24"]
    }
  ]
}

variable "labels" {
  description = "A set of key/value label pairs to assign."
  type        = map(string)
  default     = {}
}

````