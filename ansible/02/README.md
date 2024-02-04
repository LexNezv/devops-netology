# Домашнее задание к занятию 2 «Работа с Playbook»

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2. От вас не требуется использовать все возможности шаблонизатора, просто вставьте стандартный конфиг в template файл. Информация по шаблонам по [ссылке](https://www.dmosk.ru/instruktions.php?object=ansible-nginx-install). не забудьте сделать handler на перезапуск vector в случае изменения конфигурации!
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
```
WARNING  Listing 15 violation(s) that are fatal
name[missing]: All tasks should be named.
site.yml:11 Task/Handler: block/always/rescue 

risky-file-permissions: File permissions unset or incorrect.
site.yml:12 Task/Handler: Get clickhouse distrib

risky-file-permissions: File permissions unset or incorrect.
site.yml:18 Task/Handler: Get clickhouse distrib

name[casing]: All names should start with an uppercase letter.
site.yml:30 Task/Handler: copy clickhouse config

risky-file-permissions: File permissions unset or incorrect.
site.yml:30 Task/Handler: copy clickhouse config

fqcn[action-core]: Use FQCN for builtin module actions (meta).
site.yml:37 Use `ansible.builtin.meta` or `ansible.legacy.meta` instead.

jinja[spacing]: Jinja2 spacing could be improved: create_db.rc != 0 and create_db.rc !=82 -> create_db.rc != 0 and create_db.rc != 82 (warning)
site.yml:44 Jinja2 template rewrite recommendation: `create_db.rc != 0 and create_db.rc != 82`.

ignore-errors: Use failed_when and specify error conditions instead of using ignore_errors.
site.yml:50 Task/Handler: Create table

no-changed-when: Commands should not change things if nothing needs doing.
site.yml:50 Task/Handler: Create table

name[casing]: All names should start with an uppercase letter.
site.yml:62 Task/Handler: restart vector service

risky-file-permissions: File permissions unset or incorrect.
site.yml:68 Task/Handler: Get vector distrib

yaml[trailing-spaces]: Trailing spaces
site.yml:69

yaml[truthy]: Truthy value should be one of [false, true]
site.yml:82

name[casing]: All names should start with an uppercase letter.
site.yml:84 Task/Handler: copy vector config

risky-file-permissions: File permissions unset or incorrect.
site.yml:84 Task/Handler: copy vector config
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
PLAY RECAP *********************************************************************************************************************************************************************
clickhouse-01              : ok=5    changed=0    unreachable=0    failed=0    skipped=2    rescued=1    ignored=0   
vector-01                  : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```
ansible-playbook site.yml -u vagrant -kK --diff
PLAY RECAP *********************************************************************************************************************************************************************
clickhouse-01              : ok=8    changed=6    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   


```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```
PLAY RECAP *********************************************************************************************************************************************************************
clickhouse-01              : ok=7    changed=1    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook). Так же приложите скриншоты выполнения заданий №5-8
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.
