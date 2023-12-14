# Commandos básico y utiles para el curso

## Índice

1. [**Network tools**](#network-tools)
    - [Linux](#linux)
    - [Windows Power shell](#windows-power-shell)
2. [**Docker**](#docker)
    - [Trabajando con imágenes del container registry](#trabajando-con-imágenes-del-container-registry)
    - [Construyendo Imágenes](#construyendo-imágenes)
    - [Comandos Avanzados para Imágenes](#comandos-avanzados-para-imágenes)
    - [Comandos para la Gestión Básica de Contenedores](#comandos-para-la-gestión-básica-de-contenedores)
    - [Trabajando con Redes y Volúmenes](#trabajando-con-redes-y-volúmenes)
    - [Interactuando con Contenedores](#interactuando-con-contenedores)
    - [Docker Compose](#docker-compose)
    - [Administración de Redes y Volúmenes](#administración-de-redes-y-volúmenes)
    - [Comandos para Información y Estadísticas](#comandos-para-información-y-estadísticas)
    - [Comandos para Seguridad y Control de Acceso](#comandos-para-seguridad-y-control-de-acceso)
    - [Comandos para Configuraciones Avanzadas](#comandos-para-configuraciones-avanzadas)

## Network tools

### Linux

1. Install this tool to management network options

```shell
sudo apt install net-tools 
sudo apt-get install telnet
```

- Check ports listening

```shell
netstat -n --all --tcp
```

- Find specific port

```shell
sudo lsof -i -P -n | grep 9000
```

- Testing socket whit telnet, teh format telnet ipaddress port

```shell
telnet localhost 5433
```

### Windows Power shell

- Check ports listening

```powershell
Get-NetTCPConnection
```

- Obtener todas las conexiones TCP

```powershell
$connections = Get-NetTCPConnection
```

- Filtrar conexiones en estado 'Listen' o 'Established'*

```powershell
$filteredConnections = $connections | Where-Object {($_.State -eq 'Listen') -or ($_.State -eq 'Established')}
```

- Obtener información detallada de cada conexión*

```powershell
$connectionDetails = $filteredConnections | ForEach-Object {
    $localPort = $_.LocalPort
    $remotePort = $_.RemotePort
    $state = $_.State
    $processId = $_.OwningProcess
    $process = Get-Process -Id $processId
    $processName = $process.ProcessName

    [PSCustomObject]@{
        LocalPort = $localPort
        RemotePort = $remotePort
        State = $state
        Application = $processName
    }
}
```

- Mostrar la información en la consola

```powershell
$connectionDetails
```

- Find specific port

```powershell
Get-NetTCPConnection | Where-Object {$_.LocalPort -eq 9000}
```

- Testing socket whit telnet, teh format telnet ipaddress port

```powershell
Test-NetConnection -ComputerName localhost -Port 5433
```

## **Docker**

### Trabajando con imágenes del container registry

- **Descargar una imagen desde Docker Hub:**

```shell
#docker pull nombre_de_la_imagen
docker run -d -p 80:80 docker/getting-started
```

- **Listar imágenes locales:**

```shell
docker image ls
```

- **Crear y ejecutar un contenedor a partir de una imagen:**

```shell
#docker run [opciones] nombre_del_contenedor nombre_de_la_imagen
docker run -p 80:80 -p 7080:7080 --name containerBilling sotobotero/billingapp
```

- **crear un contenedor de postgres y una base de datos en el mismo comando:**

```shell
docker run --ulimit memlock=-1:-1 -d --name postgres -e POSTGRES_USER=sa -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=product_db -p 5432:5432 postgres:13.3
```

- **Listar contenedores en ejecución:**

```shell
docker ps
```

- **Listar todos los contenedores (incluso los detenidos):**

```shell
docker ps -a
```

- **Detener todos los contenedores:**

```shell
docker stop $(docker ps -q)
```

- **Iniciar todos los contenedores:**

```shell
docker start $(docker ps -a -q)
```

- **Eliminar todos los contenedores:**

```shell
docker rm $(docker ps -a -q)
```

### Construyendo Imágenes

- **Construir una imagen desde un Dockerfile:**

 ```shell
 #docker build -t nombre_de_la_imagen [opciones y parametros] .
 docker build -t billingapp --no-cache --build-arg JAR_FILE=target/*.jar .
```

- **Construir una imagen con un contexto específico:**

 ```shell
  docker build -t nombre_de_la_imagen -f ruta/Dockerfile .
```

### Comandos Avanzados para Imágenes

- **Etiquetar una imagen:**

 ```shell
 docker tag nombre_de_la_imagen nueva_etiqueta
```

- **Loguears en un registry:**

 ```shell
docker login # te pedirá usuario y contraseña
 ```

- **Subir una imagen a Docker Hub:**

 ```shell
  docker push nombre_de_la_imagen
```

- **Descargar una imagen con una etiqueta específica:**

 ```shell
  docker pull nombre_de_la_imagen:etiqueta
```

- **Desloguearse de un registry:**

 ```shell
docker logout
 ```

### Comandos para la Gestión Básica de Contenedores

- **Detener un contenedor en ejecución:**

```shell
docker stop nombre_del_contenedor
```

- **Iniciar un contenedor detenido:**

```shell
docker start nombre_del_contenedor
```

- **Eliminar un contenedor:**

```shell
docker rm nombre_del_contenedor
```

- **Eliminar una imagen local:**

```shell
docker image rm nombre_de_la_imagen
```

### Trabajando con Redes y Volúmenes

- **Crear una red personalizada:**

 ```shell
 docker network create nombre_de_la_red
```

- **Listar redes:**

 ```shell
 docker network ls
```

- **Crear un volumen:**

 ```shell
 docker volume create nombre_del_volumen
```

- **Listar volúmenes:**

 ```shell
 docker volume ls
```

### Interactuando con Contenedores

- **Ejecutar un comando en un contenedor en ejecución:**

 ```shell
 #docker exec -it nombre_del_contenedor comando
docker exec -it localbillingApp sh
```

- **Copiar archivos entre el host y un contenedor:**

 ```shell
  docker cp archivo.txt nombre_del_contenedor:/ruta/destino
  ```

### Docker Compose

- **Iniciar contenedores definidos en un archivo `docker-compose.yml`:**

 ```shell
  docker-compose up
```

- **Escalar servicios en Docker Compose:**

 ```shell
  docker-compose scale servicio=num_instancias
```

- **Detener y eliminar contenedores definidos en Docker Compose:**

 ```shell
  docker-compose down
```

- **Ver logs de servicios en Docker Compose:**

 ```shell
  docker-compose logs servicio
```

### Administración de Redes y Volúmenes

- **Eliminar una red:**

 ```shell
  docker network rm nombre_de_la_red
```

- **Eliminar un volumen:**

 ```shell
  docker volume rm nombre_del_volumen
```

- **Inspeccionar una red:**

 ```shell
 docker network inspect nombre_de_la_red
```

### Comandos para Información y Estadísticas

- **Ver detalles de un contenedor:**

 ```shell
  docker inspect nombre_del_contenedor
```

- **Obtener estadísticas de uso de recursos de un contenedor:**

 ```shell
  docker stats nombre_del_contenedor
```

- **Obtener estadísticas de uso de recursos de todos los contenedores:**

 ```shell
  docker stats
```

### Comandos para Seguridad y Control de Acceso

- **Crear un perfil de control de acceso (se requiere Docker EE):**

 ```shell
  docker trust key generate nombre_de_perfil
```

- **Especificar qué usuarios o equipos pueden o no usar Docker:**

 ```shell
  docker trust key load --alias nombre_de_perfil.pem --pem --root /etc/docker/pki/tls/private
```

- **Inhabilitar Docker para usuarios no autorizados (se requiere Docker EE):**

 ```shell
  docker trust signer remove nombre_de_perfil
```

### Comandos para Configuraciones Avanzadas

- **Crear un contenedor con un archivo de configuración personalizada:**

 ```shell
  docker run -v ruta/local:/ruta/contenedor -e variable_de_entorno=valor nombre_de_la_imagen
```

- **Especificar recursos de sistema para un contenedor (CPU, memoria, etc.):**

 ```shell
 docker run --cpu-shares=512 -m 256m nombre_de_la_imagen
```

- **Elimina todos los contenedores detenidos e imagenes que no esten en uso**

 ```shell
docker system prune --all
 ```

- **Elimina todos los volumenes que no esten en uso**

 ```shell
docker volume prune
 ```

- **Elimina todas las redes que no esten en uso, menos las por defecto (bridge, none,host)**

 ```shell
docker network prune
 ```

### Personal notes

Example 1:

- docker run -p 8080:80 -p 7080:7080 --name billingContainer sotobotero/billingapp: example image
- <http://localhost:7080/swagger-ui/swagger-ui/index.html>: swagger
- docker start billingContainer

Example 2:

- docker run --ulimit memlock=-1:-1 -d --name postgres -e POSTGRES_USER=sa -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=product_db -p 5432:5432 postgres:13.3
where

--ulimit memlock=-1:-1: This option sets the user-level memory locking limit. In this case, it is set to unlimited (-1), which means the container can use as much locked memory as needed.

-d: This flag runs the container in the background (detached mode), allowing you to continue using the terminal for other commands.

--name postgres: This flag assigns the name "postgres" to the running container. This makes it easier to reference the container in subsequent commands.

-e POSTGRES_USER=sa: This sets the environment variable POSTGRES_USER inside the PostgreSQL container to "sa," which is the username for accessing the PostgreSQL database.

-e POSTGRES_PASSWORD=admin: This sets the environment variable POSTGRES_PASSWORD inside the PostgreSQL container to "admin," which is the password for the specified user.

-e POSTGRES_DB=product_db: This sets the environment variable POSTGRES_DB inside the PostgreSQL container to "product_db," which is the name of the PostgreSQL database to be created.

-p 5432:5432: This maps port 5432 on the host to port 5432 on the container. PostgreSQL typically uses port 5432 for connections, so this allows you to access the PostgreSQL database running in the container from your host machine.

postgres:13.3: This specifies the Docker image to be used for creating the container. In this case, it's the official PostgreSQL image with version 13.3.

- docker logs postgres
- docker build -t billingapp --no-cache --build-arg JAR_FILE=target/*.jar .
Docker:

- docker push [name-of-repository]:[version]: push a imagen to a repository
- docker pull [name-of-repository]:[version]: pull a imagen to a repository
- docker run: build a container from image and run it
- docker image ls: listar
- docker ps -a: containers status
- docker ps: active containers
- docker system prune --all: delete all running containers and their images
- docker start [name]: start image
- docker stop [name]: stop image
- docker logs [name]: watch logs of the container
- docker stop $(docker ps -q): stop all the containers
- docker build -t [name] .: build a docker image from Dockerfile
- docker tag [name] [new-name]: tag a docker image
