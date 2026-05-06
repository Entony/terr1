## Домашнее задание к занятию «Продвинутые методы работы с Terraform». Карпов Антон Юрьевич

### Задание 1

1. Возьмите из демонстрации к лекции готовый код для создания с помощью двух вызовов remote-модуля -> двух ВМ, относящихся к разным проектам(marketing и analytics) используйте labels для обозначения принадлежности. В файле cloud-init.yml необходимо использовать переменную для ssh-ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} . Воспользуйтесь примером. Обратите внимание, что ssh-authorized-keys принимает в себя список, а не строку.
2. Добавьте в файл cloud-init.yml установку nginx.
3. Предоставьте скриншот подключения к консоли и вывод команды sudo nginx -t, скриншот консоли ВМ yandex cloud с их метками. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.marketing_vm

### Решение 1

[main.tf](src/main.tf)

[cloud-init.yml](src/cloud-init.yml)

Подключение к ВМ и проверка Nginx:

![alt text](image.png)

Метки в консоли Yandex Cloud:

![alt text](image-1.png)

Вывод в консоли Terraform:

![alt text](image-2.png)


### Задание 2

1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: одну сеть и одну подсеть в зоне, объявленной при вызове модуля, например: ru-central1-a.
2. Вы должны передать в модуль переменные с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью output информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev
4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.
5. Сгенерируйте документацию к модулю с помощью terraform-docs.

Пример вызова
```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```

### Решение 2

[Файлы модуля](src/module_network)

Вывод terraform console:

![alt text](image-3.png)

Документация, созданная с помощью terraform-docs:

[README.md)](src/module_network/README.md)


### Задание 3

1. Выведите список ресурсов в стейте.
2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.
4. Импортируйте всё обратно. Проверьте terraform plan. Значимых(!!) изменений быть не должно. Приложите список выполненных команд и скриншоты процессы.

### Решение 3

Вывод всех ресурсов:

![alt text](image-4.png)

Удаление модулей из state:

![alt text](image-5.png)

Импорт:

![alt text](image-6.png)

Результат:

![alt text](image-7.png)

Вывод terraform plan:

![alt text](image-8.png)


### Задание 4*

Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.

Пример вызова
```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

Предоставьте код, план выполнения, результат из консоли YC.

### Решение 4

Измененный модуль [main.tf](src/module_network/main.tf)

Изменения в основном модуле [main.tf](src/main.tf)

[План выполнения](plan.txt)

Результат в консоли YC:

![alt text](image-9.png)


### Задание 6*

Используя готовый yandex cloud terraform module и пример его вызова(examples/simple-bucket): https://github.com/terraform-yc-modules/terraform-yc-s3 . Создайте и не удаляйте для себя s3 бакет размером 1 ГБ(это бесплатно), он пригодится вам в ДЗ к 5 лекции.

### Решение 6

[Каталог для создания бакета](bucket)

Создан бакет размером 1 Гб:

![alt text](image-10.png)


### Задание 7*

1. Разверните у себя локально vault, используя docker-compose.yml в проекте.
2. Для входа в web-интерфейс и авторизации terraform в vault используйте токен "education".
3. Создайте новый секрет по пути http://127.0.0.1:8200/ui/vault/secrets/secret/create Path: example
secret data key: test secret data value: congrats!
4. Считайте этот секрет с помощью terraform и выведите его в output по примеру:
```
provider "vault" {
 address = "http://<IP_ADDRESS>:<PORT_NUMBER>"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 
```

Можно обратиться не к словарю, а конкретному ключу:
```
terraform console: >nonsensitive(data.vault_generic_secret.vault_example.data.<имя ключа в секрете>)
```
5. Попробуйте самостоятельно разобраться в документации и записать новый секрет в vault с помощью terraform.

### Решение 7

[main.tf](vault/main.tf)

Создан секрет в веб-интерфейсе:

![alt text](image-11.png)

Вывод секрета из vault:

![alt text](image-12.png)

Проверка создания нового секрета в Vault:

![alt text](image-13.png)


### Задание 8*

Попробуйте самостоятельно разобраться в документации и с помощью terraform remote state разделить root модуль на два отдельных root-модуля: создание VPC , создание ВМ.

### Решение 8

[Папка проекта](remote)

Проект разделен на 2 модуля: vms и vpc.
Результат в YC:

![alt text](image-14.png)





