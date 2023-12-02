
- Приложите скриншот вывода команды ```terraform --version```.
![image](https://github.com/LexNezv/devops-netology/assets/60059176/11fa9839-ab92-47b1-b678-eb83bee8b5e8)
- В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?
  - в файле personal.auto.tfvars
- Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.
  - ответ ```"result": "puQivkOIkBmxk7Vt"```
- Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
  - в 24 строчке мы не дали имя, только тип
  - в 29 скрочке нельзя давать имя, которое начинается с цифры
  - в 31 строке идет ссылка на необъявленный в рут модуле ресурс + ошибка с большой буквой в слове result (неверный атрибут)
- Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды docker ps
```
resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}


resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 8000
  }
}
```
```
docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
a7a918ca2851   a6bd71f48f68   "/docker-entrypoint.…"   27 seconds ago   Up 26 seconds   0.0.0.0:8000->80/tcp   example_puQivkOIkBmxk7Vt
```

