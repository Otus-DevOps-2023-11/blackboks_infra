# blackboks_infra
blackboks Infra repository

## Знакомство с облачной инфраструктурой Yandex.Cloud

### Виртуальные машины:
bastion_IP = 84.201.128.49
someinternalhost_IP = 10.128.0.4


### Подключение к someinternalhost в одну команду:
ssh -i ~/.ssh/appuser -A -J appuser@84.201.128.49 appuser@10.128.0.4


### Подключение к someintenralhost через alias:
Для этого в файл ~/.ssh/config добавить следующие строки:

```
Host bastion
        HostName 84.201.128.49
        User appuser
        IdentityFile ~/.ssh/appuser

Host someinternalhost
        HostName 10.128.0.4
        User appuser
        IdentityFile ~/.ssh/appuser
```

Сама команда:

ssh -i ~/.ssh/appuser -A -J bastion someinternalhost (без использования vpn)


### Дополнительное задание по vpn серверу:

Защищенное соединение для веб интерфеса vpn сервера находится по адресу https://84.201.128.49.nip.io/



## ДЗ 4 - Деплой тестового приложения


### Приложение развернуто, данные для проверки:


testapp_IP = 158.160.106.157
testapp_port = 9292


### Дополнительное задание - создать startup script:

Выполнено за счет дополнительного флага --metadata-from-fileuser-data=cloud-init.yaml для команды yc compute instance create


## ДЗ 5 - Сборка образов VM  при помощи Packer


### Было сделано:

* Установлен Packer
* Создан сервисный аккаунт в YC
* Создан файл ключа для сервисного аккаунта
* Создан шаблон Packer
* Установлен билдер yandex - packer plugins install github.com/hashicorp/yandex
* В шаблон добавлены провизионеры shell и file
* Выполнено параметризирование шаблона, добавлен файл с переменными (оригинальный файл скрыт через .gitignore)
* Добавлены дополнительные опции для билдера, в частности instance_cores, instance_mem_gb, disk_size_gb и некоторые другие
* Создан bake образ, при развертывании которого приложение сразу начинает работать, дополнительная установка компонентов в данном случае не требуется
* Создан скрипт для деплоя ВМ из подгототвленного ранее bake  образа


## ДЗ 6 - Знакомство с Terraform


### Было сделано:

* Установлен Terraform
* Создан сервисный аккаунт в YC
* Создан файл ключа для сервисного аккаунта
* В .gitignore добавлены служебные файлы Terraform
* Загружен yandex провайдер для Teraform
* Изучены команды terraform plan, terraform apply, terraform show, terraform destroy
* Созданы файлы с переменными ввода variables.tf, terraform.tfvars
* Создан файл с переменными вывода output.tf
* Создан инстанс ВМ с использованием переменных ввода
* Добавлен второй инстанс ВМ путем копирования кода
* Создан балансировщик нагрузки и целевая группа для него
* Инстансы ВМ удалены, созданы заново с параметром count, добавлены в целевую группу балансировщика
* Проверена конфигурауция с ипользованием динамеческой целевой группы (https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks)


## ДЗ 7 - Инфраструктура как код, командная работа с Terraform


### Было сделано:
* C помощью Packer созданы 2 образа - один с приложением, второй с базой данных
* Основная конфигурация в файле main.tf разбита на две по типу инстанса - app.tf и db.tf
* Конфигурация сети так же выделена в отдельный файл vpc.tf
* Для каждого инстанса (app, db) добавлена переменная в output.tf
* Добавлены модули app и db, каждый со своими входными и выходными переменными
* Произведено подключение модулей в создданные среды stage и prod, путем создания в каждом из этих каталогов основных файлов terraform (main.tf, variables.tf, terraform.tfvars и тд.)
* Задание со :star: - Созданы access и secret ключи для сервисного аккаунта terraform https://cloud.yandex.ru/ru/docs/iam/operations/sa/create-access-key
* Задание со :star: - С помощью полученных ранее ключей создан s3 бакет tf-state-files
* Задание со :star: - Для каждой из сред созданы и проинициализированиы backend.tf файлы
* Задание со :star: - tfstate файлы хранятся в бакете в соответствующем каталоге при одновременном запуске двух конфигураций блокировки не происходило, т.к использование s3 этого не подразумевает (вариант с DynamoDB https://ru.hexlet.io/courses/terraform-basics/lessons/remote-state/theory_unit)
* Задание с :star: :star: - В main.tf файлы модулей добавлены провижионеры, в каталоги с модулями перенесены скрипты



## ДЗ 8 - Управление конфигурацией, знакомство с Ansible


### Было сделано:
* Через менеджер пакетов установлен Ansible
* Создан inventory файл
* Проверена доступность и работоспособность хостов с помощью модулей ping и command
* Создан файл ansible.cfg, в который перенесена часть настроек из inventory, в частности указан путь к inventory, удаленный пользователь, путь к приватному ключу удаленного пользователя.
* В файл inventory добавлены группы, проверена работоспособность
* Создан inventory.yml, проверена работоспособность
* Проверена работа основных компонентов на инстансах app и db c помощью модулей shell, systemctl, service
* Проверена работа модуля git напрямую и через модуль command
* Создан playbook clone.yml с молулем  git для клонирования репозитория reddit, протестирован два раза, т.к при первом запуске никаких изменений не было, потому что этот репозиторий уже был склонирован ранее в предыдущих дз.
* Удален репозиторий reddit из домашнего каталога, плейбук запущен повторно, в выводе консоли  change = true, что означает что репозиторий был успешно склонирован заново


## ДЗ 9 - Деплой и управление конфигурацией с Ansible

### Было сделано:
* Создан плейбук с одним сценарием, полностью описывающим настройку инстансов db и app
* Добавлены шаблоны jinja для конфигурации
* Добавлены хендлеры на перезапуск сервиса
* Создан плейбук с несколькими раздельными сценариями, каждый из которых выполняет определенные операции с инстансами
* Установлен плагин ansible для packer - packer plugins install github.com/hashicorp/ansible
* В файлах packer имеющиеся провижионеры заменены на ansible
* Созданые новые образы с помощью ansible провижионера, протестирована работа приложения


## ДЗ 10 - Ansible: работа с ролями и окружениями

### Было сделано:
* Coзданы роли app и db
* В ./tasks/main.yml для каждой роли скопированы секции task из соответствующих плейбуков
* В ./templates для каждой роли скопированы шаблоны конфигурации, изменен путь в src
* Подобным образом в роли перенесены хендлеры и файлы
* В ./defaults/main.yml для каждой роли записаны значения по умолчанию
* Проведена проверка работы ролей на stage окружении
* Созданы каталоги environments/stage и environments/prod для хранения настроек окружения, в каждый каталог скопирован файл инвентаря
* В ansible.cfg указан инвентарь по умолчанию
* Созданы файлы переменных групп хостов в каталоге group_vars для каждого окружения, в эти файлы перенесены значения из плейбуков app и db
* Создан файл переменных для группы хостов all
* В каждой роли настроен вывод информации об окружении
* Улучшена структура каталона ansible, добавлены опции в файл ansible.cfg
* Проверена работа приложения в stage и prod окружениях
* Установлена роль jdauphant.nginx, для нее добавлены переменные в окружения, протестирована работа приложения в prod окружении на 80 порту
* Создан vault.key, в ansible.cfg указан путь к этому файлу, в каталогах окружений созданы файлы credentials.yml, содержащие данные о пользователях, добавлен плейбук users.yml
* Файлы credentials.yml зашифрованы с помощью команды ansible-vault encrypt
* Проверена работа ролей с использованием зашифрованных файлов переменных окружения

