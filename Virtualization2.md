# Задача 1
- Опишите основные преимущества применения на практике IaaC-паттернов.
  - Удобная совместная работа, у всех одинаковое понимание как выглядит инфраструктура
  - Ускоряет процесс разворачивания инфраструктуры
  - Возможность провести тестирование
  - Легко масштабировать ресурсы, быстрый деплой
  - Быстрый откат изменений
  - Легче поддерживать ПО в актуальном состоянии
- Какой из принципов IaaC является основополагающим?
  - Идемпотентность

# Задача 2
- Чем Ansible выгодно отличается от других систем управление конфигурациями?
  - бесплатный
  - не требует установки дополнительного ПО на хосты
  - разработкой занимается крупная компания - RedHat
- Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?
  - push, может храниться у любого участника, нет точек отказа, кроме потери хранилища кода и всех копий на локальных ПК учасников

# Задача 3
Установите на личный linux-компьютер(или учебную ВМ с linux):
- vbox
```
virtualbox                                 6.1.38-dfsg-3~ubuntu1.22.04.1           amd64        x86 virtualization solution - base binaries
```
- vagrant
```
Vagrant 2.4.0
```
- ansible
```
ansible [core 2.15.6]
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.10/dist-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.10.12 (main, Jun 11 2023, 05:26:28) [GCC 11.4.0] (/usr/bin/python3)
  jinja version = 3.1.2
  libyaml = True
```
- terraform
```
Terraform v1.6.3
on linux_amd64
```
