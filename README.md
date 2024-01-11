# blackboks_infra
blackboks Infra repository

## Знакомство с облачной инфраструктурой Yandex.Cloud

### Виртуальные машины:
- bastion_IP = 84.201.128.49
- someinternalhost_IP = 10.128.0.4


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
