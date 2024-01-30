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
