
## Задание 1
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
- Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```. Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды ```docker ps```
  - Применение команды terraform apply -auto-approve может быть опасным, так как она автоматически применяет все изменения, указанные в файле конфигурации, без какого-либо подтверждения или проверки.
  - Полезным может быть, если нужно будет сделать какую-нибудь автоматику. Например чтобы отрабатывал gitlab ci, после пуша в репозиторий.
```
docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
b0439aef5f29   a6bd71f48f68   "/docker-entrypoint.…"   6 seconds ago   Up 5 seconds   0.0.0.0:8000->80/tcp   hello_world
```
- Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**.
```
{
  "version": 4,
  "terraform_version": "1.6.5",
  "serial": 11,
  "lineage": "b9e1a454-2112-8c7c-6770-7b9a48401774",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```
- Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ **обязательно** подкрепите строчкой из документации [**terraform провайдера docker**](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs).  (ищите в классификаторе resource docker_image )
  - Потому что мы указали, что его нужно сохранить с помощью keep_locally.
  ```
  keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.
  ```