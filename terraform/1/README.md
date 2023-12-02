
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
keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage destroy operation.
```

## Задание 2

1. Изучите в документации provider [**Virtualbox**](https://docs.comcloud.xyz/providers/shekeriev/virtualbox/latest/docs) от
shekeriev.
2. Создайте с его помощью любую виртуальную машину. Чтобы не использовать VPN, советуем выбрать любой образ с расположением в GitHub из [**списка**](https://www.vagrantbox.es/).

В качестве ответа приложите plan для создаваемого ресурса и скриншот созданного в VB ресурса.

- Сначала пробовал запустить example из документации, выдавалась ошибка. Попробовал разные образы из приложенной ссылки.
```
│ Error: unable to start VM: exit status 1
│
│   with virtualbox_vm.vm1,
│   on main.tf line 15, in resource "virtualbox_vm" "vm1":
│   15: resource "virtualbox_vm" "vm1" {
```

В итоге с помощью вагранта ```vagrant package --base image --output ./mybox.box``` упаковал образ в бокс и терраформ и он создался но не запускался.
Оказалось, что "hostonly" устаревший тип адаптера для виртуалбокс, сменил на nat и все завелось.
![image](https://github.com/LexNezv/devops-netology/assets/60059176/dd265678-93a2-4a47-9e23-afc429f7411d)

Снимок экрана с запущенной ВМ:

![image](https://github.com/LexNezv/devops-netology/assets/60059176/34b00f75-1fd1-4445-9fd6-7caba5970cf4)


Терраформ план:
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # virtualbox_vm.virtualtest will be created
  + resource "virtualbox_vm" "virtualtest" {
      + cpus   = 1
      + id     = (known after apply)
      + image  = "./mybox.box"
      + memory = "1024 mib"
      + name   = "testvm"
      + status = "running"

      + network_adapter {
          + device                 = "IntelPro1000MTDesktop"
          + host_interface         = "vboxnet1"
          + ipv4_address           = (known after apply)
          + ipv4_address_available = (known after apply)
          + mac_address            = (known after apply)
          + status                 = (known after apply)
          + type                   = "nat"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + IPAddress = (known after apply)

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```
