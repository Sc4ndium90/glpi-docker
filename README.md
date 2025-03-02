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
