# Домашнее задание к занятию «Микросервисы: подходы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.


## Задача 1: Обеспечить разработку

Предложите решение для обеспечения процесса разработки: хранение исходного кода, непрерывная интеграция и непрерывная поставка. 
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- облачная система;
- система контроля версий Git;
- репозиторий на каждый сервис;
- запуск сборки по событию из системы контроля версий;
- запуск сборки по кнопке с указанием параметров;
- возможность привязать настройки к каждой сборке;
- возможность создания шаблонов для различных конфигураций сборок;
- возможность безопасного хранения секретных данных (пароли, ключи доступа);
- несколько конфигураций для сборки из одного репозитория;
- кастомные шаги при сборке;
- собственные докер-образы для сборки проектов;
- возможность развернуть агентов сборки на собственных серверах;
- возможность параллельного запуска нескольких сборок;
- возможность параллельного запуска тестов.

Обоснуйте свой выбор.

**Ответ**

Для обеспечения процесса разработки с учетом указанных требований, я предлагаю использовать комбинацию следующих облачных сервисов и инструментов:

1. **GitHub/GitLab** - для хранения исходного кода и управления версиями.
2. **GitHub Actions/GitLab CI/CD** - для организации непрерывной интеграции и непрерывной поставки.
3. **Docker** - для создания и управления собственными докер-образами.
4. **HashiCorp Vault/AWS Secrets Manager** - для безопасного хранения секретных данных.
5. **Kubernetes** (опционально) - для управления развертыванием и масштабированием приложений.

Соответсвие требованиям:

1. **Хранение исходного кода**:
   - Используем GitHub или GitLab как систему контроля версий. Каждый сервис (микросервис) имеет свой репозиторий, что позволяет управлять кодом независимо.

2. **Непрерывная интеграция и непрерывная поставка**:
   - GitHub Actions или GitLab CI/CD позволяют настраивать автоматические сборки и развертывания. 
   - Сборка может быть запущена автоматически по событиям (например, push в репозиторий), а также вручную по кнопке с параметрами.

3. **Запуск сборки по событию и вручную**:
   - В GitHub Actions можно использовать триггеры на основе событий, таких как push или pull request. 
   - Также можно настроить ручные триггеры с помощью workflow_dispatch, позволяя указать параметры для сборки.

4. **Привязка настроек к каждой сборке**:
   - Можно использовать переменные окружения и конфигурационные файлы для хранения настроек, которые могут быть привязаны к каждой сборке.

5. **Создание шаблонов для различных конфигураций сборок**:
   - В GitHub Actions и GitLab CI/CD можно создавать шаблоны для различных конфигураций, используя reusable workflows или include директивы.

6. **Безопасное хранение секретных данных**:
   - HashiCorp Vault или AWS Secrets Manager могут быть использованы для безопасного хранения паролей и ключей доступа, которые затем могут быть интегрированы в процесс сборки.

7. **Несколько конфигураций для сборки из одного репозитория**:
   - В CI/CD системах можно настроить разные jobs для различных конфигураций сборки, используя условия и переменные.

8. **Кастомные шаги при сборке**:
   - Можно добавлять кастомные шаги в workflow файлы, чтобы выполнять специфические команды или скрипты.

9. **Собственные докер-образы для сборки проектов**:
   - Docker позволяет создавать собственные образы, которые можно использовать в процессе сборки и тестирования.

10. **Развертывание агентов сборки на собственных серверах**:
    - GitLab CI/CD позволяет настраивать собственные runners, которые могут быть развернуты на локальных серверах.

11. **Параллельный запуск нескольких сборок и тестов**:
    - GitHub Actions и GitLab CI/CD поддерживают параллельное выполнение jobs, что позволяет ускорить процесс сборки и тестирования.

Почему:

- **Облачные решения**: GitHub и GitLab предоставляют облачные решения с высоким уровнем доступности и масштабируемости.
- **Поддержка Git**: Обе платформы полностью поддерживают Git как систему контроля версий, что делает их удобными для работы с кодом.
- **Гибкость CI/CD**: GitHub Actions и GitLab CI/CD предлагают мощные инструменты для настройки процессов CI/CD с возможностью использования кастомных шагов, параллельных задач и шаблонов.
- **Безопасность**: HashiCorp Vault и AWS Secrets Manager обеспечивают надежное хранение секретных данных, что критично для безопасности приложений.
- **Контейнеризация**: Docker позволяет стандартизировать окружение разработки и тестирования, что упрощает процесс развертывания.

Таким образом, предложенное решение соответствует всем требованиям и предоставляет гибкие инструменты для управления процессами разработки.

## Задача 2: Логи

Предложите решение для обеспечения сбора и анализа логов сервисов в микросервисной архитектуре.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- сбор логов в центральное хранилище со всех хостов, обслуживающих систему;
- минимальные требования к приложениям, сбор логов из stdout;
- гарантированная доставка логов до центрального хранилища;
- обеспечение поиска и фильтрации по записям логов;
- обеспечение пользовательского интерфейса с возможностью предоставления доступа разработчикам для поиска по записям логов;
- возможность дать ссылку на сохранённый поиск по записям логов.

Обоснуйте свой выбор.

**Ответ**

Для обеспечения сбора и анализа логов в микросервисной архитектуре можно предложить решение, основанное на использовании стека ELK (Elasticsearch, Logstash, Kibana) или его аналогов, таких как EFK (Elasticsearch, Fluentd, Kibana). Это решение будет соответствовать всем указанным требованиям.

Архитектура решения:

1. Сбор логов:
   - Fluentd или Logstash: Эти инструменты будут собирать логи из stdout приложений. Они могут быть развернуты на каждом хосте, где работают микросервисы. Fluentd и Logstash могут быть настроены для чтения логов из стандартного вывода контейнеров (например, Docker), а также из файлов логов.
   - Docker Logging Driver: Если вы используете Docker, можно настроить драйвер логирования для контейнеров, чтобы отправлять логи напрямую в Fluentd или Logstash.

2. Централизованное хранилище:
   - Elasticsearch: Этот компонент будет служить центральным хранилищем для всех собранных логов. Elasticsearch обеспечивает высокую производительность поиска и фильтрации, что соответствует требованиям по обеспечению поиска и фильтрации по записям логов.

3. Анализ и визуализация:
   - Kibana: Этот инструмент предоставляет веб-интерфейс для визуализации и анализа логов, собранных в Elasticsearch. Kibana позволяет пользователям создавать дашборды, графики и проводить поиск по записям логов. Также можно настроить доступ для разработчиков для выполнения поисковых запросов.

Взаимодействие компонентов:

- Сбор логов: 
  - Приложения записывают логи в stdout.
  - Fluentd/Logstash на каждом хосте собирает эти логи и отправляет их в Elasticsearch.
  
- Гарантированная доставка:
  - Fluentd и Logstash поддерживают механизмы повторной попытки доставки сообщений в случае сбоя сети или недоступности Elasticsearch. Это гарантирует, что логи не потеряются.

- Поиск и фильтрация:
  - Kibana предоставляет мощные инструменты для поиска и фильтрации по записям логов. Пользователи могут выполнять запросы на основе различных полей логов и создавать визуализации.

- Сохраненные поиски:
  - В Kibana можно сохранять поисковые запросы и делиться ссылками на них с другими пользователями. Это позволяет разработчикам быстро возвращаться к часто используемым запросам.

Обоснование:

- Гибкость: Стек ELK/EFK является гибким решением, которое может быть адаптировано под различные требования и нагрузки.
- Широкая поддержка: Эти инструменты имеют большую сообщество, множество документации и примеров использования.
- Масштабируемость: Elasticsearch может обрабатывать большие объемы данных, что делает его подходящим для микросервисной архитектуры с потенциально большим количеством логов.
- Простота интеграции: Интеграция с существующими приложениями минимальна, так как большинство современных фреймворков поддерживают вывод логов в stdout.

Таким образом, предложенное решение обеспечивает эффективный сбор, хранение и анализ логов в микросервисной архитектуре, соответствуя всем заявленным требованиям.

## Задача 3: Мониторинг

Предложите решение для обеспечения сбора и анализа состояния хостов и сервисов в микросервисной архитектуре.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- сбор метрик со всех хостов, обслуживающих систему;
- сбор метрик состояния ресурсов хостов: CPU, RAM, HDD, Network;
- сбор метрик потребляемых ресурсов для каждого сервиса: CPU, RAM, HDD, Network;
- сбор метрик, специфичных для каждого сервиса;
- пользовательский интерфейс с возможностью делать запросы и агрегировать информацию;
- пользовательский интерфейс с возможностью настраивать различные панели для отслеживания состояния системы.

Обоснуйте свой выбор.

**Ответ**

Для обеспечения сбора и анализа состояния хостов и сервисов в микросервисной архитектуре можно использовать комбинацию следующих программных продуктов:

1. Prometheus - для сбора и хранения метрик.
2. Grafana - для визуализации данных и создания пользовательских панелей.
3. Node Exporter - для сбора метрик состояния ресурсов хостов (CPU, RAM, HDD, Network).
4. cAdvisor - для мониторинга контейнеров и сбора метрик потребляемых ресурсов для каждого сервиса.
5. Custom Exporters - для сбора специфичных метрик каждого сервиса, если стандартные решения не подходят.

Описание:

1. Сбор метрик с хостов:
   - Node Exporter устанавливается на каждом хосте и собирает системные метрики (CPU, RAM, HDD, Network). Он предоставляет эти данные в формате, который понимает Prometheus.

2. Сбор метрик сервисов:
   - cAdvisor может быть развернут на каждом контейнере (если используются контейнеры) для сбора метрик по потреблению ресурсов (CPU, RAM, HDD, Network) для каждого сервиса.
   - Если сервисы не работают в контейнерах, можно написать Custom Exporters, которые будут собирать специфичные метрики из логики приложения и предоставлять их Prometheus.

3. Хранение и обработка метрик:
   - Prometheus будет собирать метрики от Node Exporter, cAdvisor и Custom Exporters с заданным интервалом времени. Он хранит данные в своей базе данных и предоставляет API для запроса метрик.

4. Визуализация:
   - Grafana интегрируется с Prometheus как источник данных. В Grafana можно создавать дашборды для визуализации собранных метрик. Пользователи смогут настраивать панели для отслеживания состояния системы, а также делать запросы к данным через интерфейс Grafana.

5. Пользовательский интерфейс:
   - Grafana предоставляет мощный интерфейс для создания пользовательских дашбордов с возможностью добавления различных графиков, таблиц и других визуальных элементов. Пользователи могут легко настраивать панели для отображения интересующих их метрик.

Обоснование:

- Prometheus является де-факто стандартом для мониторинга в микросервисных архитектурах благодаря своей гибкости, возможности работы с временными рядами и мощной системе запросов (PromQL).
- Grafana отлично подходит для визуализации данных и позволяет создавать интерактивные дашборды, которые легко настраиваются под потребности пользователей.
- Node Exporter и cAdvisor обеспечивают сбор системных и контейнерных метрик без необходимости написания сложного кода.
- Возможность использования Custom Exporters дает гибкость в сборе специфичных метрик для разных сервисов, что особенно важно в микросервисной архитектуре.

Таким образом, данное решение обеспечивает полное покрытие требований к мониторингу и анализу состояния хостов и сервисов в микросервисной архитектуре.

## Задача 4: Логи * (необязательная)

Продолжить работу по задаче API Gateway: сервисы, используемые в задаче, пишут логи в stdout. 

Добавить в систему сервисы для сбора логов Vector + ElasticSearch + Kibana со всех сервисов, обеспечивающих работу API.

### Результат выполнения: 

docker compose файл, запустив который можно перейти по адресу http://localhost:8081, по которому доступна Kibana.
Логин в Kibana должен быть admin, пароль qwerty123456.


## Задача 5: Мониторинг * (необязательная)

Продолжить работу по задаче API Gateway: сервисы, используемые в задаче, предоставляют набор метрик в формате prometheus:

- сервис security по адресу /metrics,
- сервис uploader по адресу /metrics,
- сервис storage (minio) по адресу /minio/v2/metrics/cluster.

Добавить в систему сервисы для сбора метрик (Prometheus и Grafana) со всех сервисов, обеспечивающих работу API.
Построить в Graphana dashboard, показывающий распределение запросов по сервисам.

### Результат выполнения: 

docker compose файл, запустив который можно перейти по адресу http://localhost:8081, по которому доступна Grafana с настроенным Dashboard.
Логин в Grafana должен быть admin, пароль qwerty123456.

---

