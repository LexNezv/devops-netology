# Задача 1

Дайте письменые ответы на следующие вопросы:

- В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?
  - В режиме replication сервис будет иметь указанное количество реплик.
  - В global режиме сервис будет развернут одной репликой на каждой node в кластере. 
- Какой алгоритм выбора лидера используется в Docker Swarm кластере?
  - Raft
- Что такое Overlay Network?
  - Виртуальная сеть, которая работает по верх физических сетей. Используется Docker Swarm для связи node на которых запущен Docker.

# Задача 2

Создать ваш первый Docker Swarm кластер в Яндекс.Облаке

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker node ls
```
![image](https://github.com/LexNezv/devops-netology/assets/60059176/5c3b4ac7-0195-4f63-91a0-297de468db85)


# Задача 3

Создать ваш первый, готовый к боевой эксплуатации кластер мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить скриншот из терминала (консоли), с выводом команды:
```
docker service ls
```
![image](https://github.com/LexNezv/devops-netology/assets/60059176/c48e4bc1-24ac-4f7f-af42-7008b7ab2f00)
