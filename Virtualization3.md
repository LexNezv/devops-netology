# Задача 1
Опубликуйте созданный fork в своём репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.
```
https://hub.docker.com/r/lexnezv/netologynginx
```
```
docker pull lexnezv/netologynginx
```
# Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
«Подходит ли в этом сценарии использование Docker-контейнеров или лучше подойдёт виртуальная машина, физическая машина? Может быть, возможны разные варианты?»

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- высоконагруженное монолитное Java веб-приложение;
  - Виртуальная машина. Монолит не подразумевает использование контейнеров. 
- Nodejs веб-приложение;
  - Контейнеры. Удобство деплоя и микросервисная архитектура.
- мобильное приложение c версиями для Android и iOS;
  - Физическая машина. Если есть возможность - виртуальная. Сборка и тестирование происходит на мобильных ОС
- шина данных на базе Apache Kafka;
  - Виртуальная машина. Приложение требовательно к ресурсам системы, чуствительно к нагрузкам и к сети, собирается в кластер.
- Elasticsearch-кластер для реализации логирования продуктивного веб-приложения — три ноды elasticsearch, два logstash и две ноды kibana;\
  - Виртуальные машины. Удобнее управлять, не является стейтлесс сервисом.
- мониторинг-стек на базе Prometheus и Grafana;
  - Контейнер и\или виртуальные машины. Зависит от того, как настраивать.
- MongoDB как основное хранилище данных для Java-приложения;
  - Контейнер и\или виртуальные машины. Зависит от того, как настраивать.
- Gitlab-сервер для реализации CI/CD-процессов и приватный (закрытый) Docker Registry.
  - Контейнер и\или виртуальные машины. Зависит от того, как настраивать.

# Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера.
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.
- Добавьте ещё один файл в папку ```/data``` на хостовой машине.
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

```
root@user-netology:~# docker image ls
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
debian        latest    fd7391105260   11 days ago    117MB
centos        latest    5d0da3dc9764   2 years ago    231MB

root@user-netology:~# mkdir /data

root@user-netology:~# docker run -d -it -v /data:/data centos:latest
945c002ae0722b0c4750756eac0d4ccc4c7f63db694cc7aa1e4592f8375f3579
root@user-netology:~# docker run -d -it -v /data:/data debian:latest
50f89305d1817b17b33a41930d9f683cc3757b2c1ae07db9966c7c361580a242

root@user-netology:~# docker ps
CONTAINER ID   IMAGE           COMMAND       CREATED              STATUS              PORTS     NAMES
50f89305d181   debian:latest   "bash"        About a minute ago   Up About a minute             dreamy_torvalds
945c002ae072   centos:latest   "/bin/bash"   About a minute ago   Up About a minute             agitated_kowalevski

root@user-netology:~# docker exec dreamy_torvalds touch /data/testfile
root@user-netology:~# docker exec agitated_kowalevski ls -l /data/testfile
-rw-r--r-- 1 root root 0 Nov 12 13:47 /data/testfile


```

## Задача 4 (*)

Воспроизведите практическую часть лекции самостоятельно.

Соберите Docker-образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.
