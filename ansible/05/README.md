# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению

1. Установите molecule и его драйвера: `pip3 install "molecule molecule_docker molecule_podman`.
1.1. Поставить libssl-dev
2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, to x и несколькими пайтонами (3.7 и 3.9) внутри.

## Основная часть

Ваша цель — настроить тестирование ваших ролей. 

Задача — сделать сценарии тестирования для vector. 

Ожидаемый результат — все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s ubuntu_xenial` (или с любым другим сценарием, не имеет значения) внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками или не отработать вовсе, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу И из чего может состоять сценарий тестирования.
```
CRITICAL 'molecule/ubuntu_xenial/molecule.yml' glob failed.  Exiting.
```
принципе много косяков с molecule, на которые оф. документация и гугл ответов не дает. Эту ошибку пришлось решать с помощью strace.
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
```
INFO     Initializing new scenario default...

PLAY [Create a new molecule scenario] ******************************************

TASK [Check if destination folder exists] **************************************
changed: [localhost]

TASK [Check if destination folder is empty] ************************************
ok: [localhost]

TASK [Fail if destination folder is not empty] *********************************
skipping: [localhost]

TASK [Expand templates] ********************************************************
skipping: [localhost] => (item=molecule/default/create.yml) 
skipping: [localhost] => (item=molecule/default/destroy.yml) 
changed: [localhost] => (item=molecule/default/converge.yml)
changed: [localhost] => (item=molecule/default/molecule.yml)

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Initialized scenario in /home/user/mygit/devops-netology/ansible/05/playbook/roles/vector-role/molecule/default successfully.
```
3. Добавьте несколько разных дистрибутивов (oraclelinux:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть. 
- Собрал свои образа с интерпритатором внутри.
```
  - name: test-01
    image: ubuntu-molecule:latest
    pre_build_image: true
  - name: test-02
    image: centos-molecule:latest
    pre_build_image: true
```
4. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.). 
- Он не создается автоматом как в видеолекции и в 
5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
Исправленные ошибки:
```
fatal: [test-01]: FAILED! => {"ansible_facts": {"discovered_interpreter_python": "/usr/bin/python3"}, "changed": false, "dest": "./vector_0.35.0-1_amd64.deb", "elapsed": 0, "msg": "Request failed: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate (_ssl.c:1007)>", "url": "https://packages.timber.io/vector/0.35.0/vector_0.35.0-1_amd64.deb"}

fatal: [test-02]: FAILED! => {"changed": false, "module_stderr": "/bin/sh: sudo: command not found\n", "module_stdout": "", "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error", "rc": 127}
```
Никак не получается перезапустить сервис внутри убунту контейнера во время тестов, при этом при раскатке на вм все ок
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
```
py37-ansible210 create: /opt/vector-role/.tox/py37-ansible210
py37-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,arrow==1.2.3,bcrypt==4.1.2,binaryornot==0.4.4,cached-property==1.5.2,Cerberus==1.3.5,certifi==2024.2.2,cffi==1.15.1,chardet==5.2.0,charset-normalizer==3.3.2,click==8.1.7,click-help-colors==0.9.4,cookiecutter==2.6.0,cryptography==42.0.5,distro==1.9.0,enrich==1.2.7,idna==3.6,importlib-metadata==6.7.0,Jinja2==3.1.3,jmespath==1.0.1,lxml==5.1.0,markdown-it-py==2.2.0,MarkupSafe==2.1.5,mdurl==0.1.2,molecule==3.6.1,molecule-podman==1.1.0,packaging==24.0,paramiko==2.12.0,pluggy==1.2.0,pycparser==2.21,Pygments==2.17.2,PyNaCl==1.5.0,python-dateutil==2.9.0.post0,python-slugify==8.0.4,PyYAML==6.0.1,requests==2.31.0,rich==13.7.1,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.7,zipp==3.15.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='1095172237'
py37-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py37-ansible30 create: /opt/vector-role/.tox/py37-ansible30
py37-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py37-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==1.0.0,arrow==1.2.3,bcrypt==4.1.2,binaryornot==0.4.4,cached-property==1.5.2,Cerberus==1.3.5,certifi==2024.2.2,cffi==1.15.1,chardet==5.2.0,charset-normalizer==3.3.2,click==8.1.7,click-help-colors==0.9.4,cookiecutter==2.6.0,cryptography==42.0.5,distro==1.9.0,enrich==1.2.7,idna==3.6,importlib-metadata==6.7.0,Jinja2==3.1.3,jmespath==1.0.1,lxml==5.1.0,markdown-it-py==2.2.0,MarkupSafe==2.1.5,mdurl==0.1.2,molecule==3.6.1,molecule-podman==1.1.0,packaging==24.0,paramiko==2.12.0,pluggy==1.2.0,pycparser==2.21,Pygments==2.17.2,PyNaCl==1.5.0,python-dateutil==2.9.0.post0,python-slugify==8.0.4,PyYAML==6.0.1,requests==2.31.0,rich==13.7.1,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,text-unidecode==1.3,typing_extensions==4.7.1,urllib3==2.0.7,zipp==3.15.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='1095172237'
py37-ansible30 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible30/bin/molecule test -s compatibility --destroy always (exited with code 1)
py39-ansible210 create: /opt/vector-role/.tox/py39-ansible210
py39-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py39-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==4.1.11,ansible-core==2.15.9,attrs==23.2.0,bracex==2.4,cffi==1.16.0,click==8.1.7,click-help-colors==0.9.4,cryptography==42.0.5,distro==1.9.0,enrich==1.2.7,importlib-resources==5.0.7,Jinja2==3.1.3,jmespath==1.0.1,jsonschema==4.21.1,jsonschema-specifications==2023.12.1,lxml==5.1.0,markdown-it-py==3.0.0,MarkupSafe==2.1.5,mdurl==0.1.2,molecule==6.0.3,molecule-podman==2.0.3,packaging==24.0,pluggy==1.4.0,pycparser==2.21,Pygments==2.17.2,PyYAML==6.0.1,referencing==0.34.0,resolvelib==1.0.1,rich==13.7.1,rpds-py==0.18.0,selinux==0.3.0,subprocess-tee==0.4.1,typing_extensions==4.10.0,wcmatch==8.5.1
py39-ansible210 run-test-pre: PYTHONHASHSEED='1095172237'
py39-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
py39-ansible30 create: /opt/vector-role/.tox/py39-ansible30
py39-ansible30 installdeps: -rtox-requirements.txt, ansible<3.1
py39-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==4.1.11,ansible-core==2.15.9,attrs==23.2.0,bracex==2.4,cffi==1.16.0,click==8.1.7,click-help-colors==0.9.4,cryptography==42.0.5,distro==1.9.0,enrich==1.2.7,importlib-resources==5.0.7,Jinja2==3.1.3,jmespath==1.0.1,jsonschema==4.21.1,jsonschema-specifications==2023.12.1,lxml==5.1.0,markdown-it-py==3.0.0,MarkupSafe==2.1.5,mdurl==0.1.2,molecule==6.0.3,molecule-podman==2.0.3,packaging==24.0,pluggy==1.4.0,pycparser==2.21,Pygments==2.17.2,PyYAML==6.0.1,referencing==0.34.0,resolvelib==1.0.1,rich==13.7.1,rpds-py==0.18.0,selinux==0.3.0,subprocess-tee==0.4.1,typing_extensions==4.10.0,wcmatch==8.5.1
py39-ansible30 run-test-pre: PYTHONHASHSEED='1095172237'
py39-ansible30 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible30/bin/molecule test -s compatibility --destroy always (exited with code 1)
______________________________________________________________________________________ summary _______________________________________________________________________________________
ERROR:   py37-ansible210: commands failed
ERROR:   py37-ansible30: commands failed
ERROR:   py39-ansible210: commands failed
ERROR:   py39-ansible30: commands failed
```
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
```
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
```
Снова ошибка
6. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.
```
commands =
    full: {posargs:molecule test -s compatibility --destroy always}
    light: {posargs:molecule test}
```
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 

## Необязательная часть

1. Проделайте схожие манипуляции для создания роли LightHouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории.

В качестве решения пришлите ссылки и скриншоты этапов выполнения задания.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.
