
# Домашнее задание к занятию «Микросервисы: масштабирование»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: Кластеризация

Предложите решение для обеспечения развёртывания, запуска и управления приложениями.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- поддержка контейнеров;
- обеспечивать обнаружение сервисов и маршрутизацию запросов;
- обеспечивать возможность горизонтального масштабирования;
- обеспечивать возможность автоматического масштабирования;
- обеспечивать явное разделение ресурсов, доступных извне и внутри системы;
- обеспечивать возможность конфигурировать приложения с помощью переменных среды, в том числе с возможностью безопасного хранения чувствительных данных таких как пароли, ключи доступа, ключи шифрования и т. п.

Обоснуйте свой выбор.

**Ответ**

Для обеспечения развертывания, запуска и управления приложениями, соответствующего указанным требованиям, можно использовать стек технологий, включающий Kubernetes, Docker, Helm и HashiCorp Vault. Давайте рассмотрим, как эти компоненты взаимодействуют друг с другом и выполняют поставленные задачи.

1. Docker
Описание: Docker — это платформа для разработки, доставки и запуска приложений в контейнерах. Контейнеры изолируют приложения и их зависимости, что обеспечивает единообразие в разных средах.

Роль в решении:
- Поддержка контейнеров: Docker позволяет упаковывать приложения и их зависимости в контейнеры.
- Явное разделение ресурсов: Контейнеры могут быть настроены для работы в изолированных средах.

2. Kubernetes
Описание: Kubernetes — это система оркестрации контейнеров, которая автоматизирует развертывание, масштабирование и управление контейнеризованными приложениями.

Роль в решении:
- Обнаружение сервисов и маршрутизация запросов: Kubernetes предоставляет встроенные механизмы для обнаружения сервисов через DNS и маршрутизацию запросов с помощью сервисов и ингресс-контроллеров.
- Горизонтальное масштабирование: Kubernetes позволяет легко добавлять или удалять реплики подов в зависимости от нагрузки.
- Автоматическое масштабирование: С помощью Horizontal Pod Autoscaler можно автоматически масштабировать количество подов на основе метрик нагрузки (например, CPU или памяти).
- Разделение ресурсов: Kubernetes позволяет создавать пространства имен (namespaces), что помогает изолировать ресурсы между различными командами или проектами.

3. Helm
Описание: Helm — это менеджер пакетов для Kubernetes, который упрощает развертывание и управление приложениями в кластере Kubernetes.

Роль в решении:
- Конфигурация приложений: Helm Charts позволяют легко управлять конфигурациями приложений с использованием переменных среды. Это упрощает процесс развертывания и обновления приложений.

4. HashiCorp Vault
Описание: HashiCorp Vault — это инструмент для безопасного хранения и управления секретами, такими как пароли, ключи доступа и другие чувствительные данные.

Роль в решении:
- Безопасное хранение чувствительных данных: Vault обеспечивает безопасное хранилище для секретов и предоставляет API для доступа к ним.
- Конфигурация приложений: Приложения могут получать секреты из Vault через переменные среды или API, что позволяет избегать жесткого кодирования конфиденциальной информации.

Принципы взаимодействия:
1. Разработка: Разработчики создают приложения и упаковывают их в контейнеры с помощью Docker.
2. Развертывание: Используя Helm, команды DevOps создают и управляют релизами приложений в кластере Kubernetes.
3. Управление ресурсами: Kubernetes управляет жизненным циклом контейнеров, обеспечивая автоматическое масштабирование и балансировку нагрузки.
4. Безопасность: Секреты хранятся в HashiCorp Vault и предоставляются приложениям по мере необходимости через API или переменные среды.

Выбор данного стека технологий (Docker, Kubernetes, Helm и HashiCorp Vault) обеспечивает полное соответствие всем указанным требованиям. Он позволяет эффективно развертывать, управлять и масштабировать контейнеризованные приложения, обеспечивая при этом безопасность конфиденциальных данных.

## Задача 2: Распределённый кеш * (необязательная)

Разработчикам вашей компании понадобился распределённый кеш для организации хранения временной информации по сессиям пользователей.
Вам необходимо построить Redis Cluster, состоящий из трёх шард с тремя репликами.

### Схема:

![11-04-01](https://user-images.githubusercontent.com/1122523/114282923-9b16f900-9a4f-11eb-80aa-61ed09725760.png)

---
