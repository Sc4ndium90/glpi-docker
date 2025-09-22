# glpi-docker
Implementation of GLPI (Gestionnaire Libre de Parc Informatique) in a Docker container.

To build the image, run the following command : 
```
docker build -t <IMAGE-NAME> .
```

If you want to build GLPI with a specific version, edit the Dockerfile argument or run the following command :
```
docker build -t <IMAGE-NAME> --build-arg GLPI_VERSION="<VERSION>" . 
```

⚠️ NOT PRODUCTION READY ⚠️ You can use the following docker-compose.yaml file to run GLPI and a MariaDB database (example): 
```
services:
  glpi:
    image: glpi
    container_name: glpi
    restart: always
    networks:
      - internal
    ports:
      - "80:80"
  db:
    image: mariadb:lts
    container_name: glpi-db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: glpi
      MYSQL_USER: glpi_user
      MYSQL_PASSWORD: glpi_password
    networks:
      - internal
networks:
  internal: 
    external: false
    driver: bridge

```
